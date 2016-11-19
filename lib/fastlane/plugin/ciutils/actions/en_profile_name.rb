module Fastlane
  module Actions
    class EnProfileNameAction < Action
      def self.run(params)
        file_path = params[:path]
        profile_name = ""

        unless file_path
          file_uuid = params[:uuid]
          file_path = "~/Library/MobileDevice/Provisioning Profiles/#{file_uuid}.mobileprovision"
          file_path = File.expand_path(file_path)
        end

        if File.exist?(file_path)
          profile_xml_data = Fastlane::Actions.sh "security cms -D -i '#{file_path}'", log: false
          profile_data = Plist.parse_xml(profile_xml_data)
          profile_name = profile_data['Name']
        else
          UI.user_error! "Could not find the specified profile at path '#{file_path}'"
        end

        profile_name
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "A short description with <= 80 characters of what this action does"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: "FL_EN_PROFILE_PATH",
                                       description: "Path to the provisioning profile",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :uuid,
                                       env_name: "FL_EN_PROFILE_UUID",
                                       description: "The UUID of the provisioning profile from 'Provisioning Profiles' folder",
                                       optional: true)
        ]
      end

      def self.return_value
        "Provisioning profile name"
      end

      def self.authors
        ["Nicolae Ghimbovschi"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
