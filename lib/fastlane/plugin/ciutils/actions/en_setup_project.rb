module Fastlane
  module Actions
    module ResourceType
      XcodeProject = 1
      InfoPlist = 2
    end

    require 'yaml'
    require 'fileutils'
    require 'xcodeproj'
    require 'plist'

    class EnSetupProjectAction < Action
      def self.run(params)
        config_file = params[:config]

        unless File.exist?(config_file)
          UI.user_error!("Could not find #{config_file}! Aborting!")
          return
        end

        configurations = YAML.load_file(config_file)
        configurations.each do |file_path, settings|
            file_type = self.file_type(file_path)

            if file_type == ResourceType::XcodeProject
                  self.updateXcodeProject(file_path, settings)
            elsif file_type == ResourceType::InfoPlist
                  self.updatePlistFile(file_path, settings)
            end
        end
      end

      def self.updateXcodeProject(project_path, settings)
          project = Xcodeproj::Project.open(project_path)

          common_configurations = settings['common']

          project.targets.each do |target|
              target_configurations = settings['targets'][target.name]
              target_configurations = {} if target_configurations == nil
              target_configurations.merge!(common_configurations) unless common_configurations == nil

              target.build_configurations.each do |config|

                  target_configurations.each do |key, value|
                      value = "iPhone Distribution" if value == "iOS Distribution"
                      config.build_settings[key] = value
                  end
              end
          end
          project.save

          UI.message("#{project_path} has been updated")
      end

      def self.updatePlistFile(file_path, settings)
          plist = {}
          plist = Plist.parse_xml(file_path) if File.exist?(file_path)
          plist.merge!(settings)

          settings.each do |key, value|
              plist.delete(key) if value == nil
          end

          File.open(file_path, 'w') do |file|
              file.write(plist.to_plist)
          end

          UI.message("#{file_path} has been updated")
      end

      def self.file_type(file_path)
          return ResourceType::XcodeProject if file_path.end_with? ".xcodeproj"
          return ResourceType::InfoPlist if file_path.end_with? ".plist"
          return ResourceType::InfoPlist if file_path.end_with? ".entitlements"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Updates Xcode project, plist and entitlements file if config file is provided"
      end

      def self.details
        "Updates Xcode project, plist and entitlements file if config file is provided.

Example a project with two targets info.plist and entitlements.

TestMatch.xcodeproj:
  options:
    CODE_SIGN_IDENTITY: iOS Distribution
    DEVELOPMENT_TEAM: H86U5Z8HYB
    CODE_SIGN_STYLE: Manual
    BUNDLE_ID: com.ghimbovschi.FastlaneDemo
  targets:
    TestMatch:
      PRODUCT_BUNDLE_IDENTIFIER: ${BUNDLE_ID}
      PROVISIONING_PROFILE_SPECIFIER: match AppStore $(PRODUCT_BUNDLE_IDENTIFIER)

    keyboard:
      PRODUCT_BUNDLE_IDENTIFIER: ${BUNDLE_ID}.keyboard
      PROVISIONING_PROFILE_SPECIFIER: match AppStore $(PRODUCT_BUNDLE_IDENTIFIER)

TestMatch/Info.plist:
  CFBundleDisplayName: My App

TestMatch/TestMatch.entitlements:
  com.apple.security.application-groups: 


The config file path should be relative to fastlane folder or full path"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :config,
                                       env_name: "EN_SETUP_PROJECT_CONFIG",
                                       description: "Config file path, default it tries to load config.yaml",
                                       is_string: true,
                                       default_value: "config.yaml")
        ]
      end

      def self.authors
        ["Nicolae Ghimbovschi"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
