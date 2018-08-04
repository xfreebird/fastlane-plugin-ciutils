module Fastlane
  module Actions
    class EnInstallProvisioningProfilesAction < Action
      def self.run(params)
        profiles_dir = "#{Dir.home}/Library/MobileDevice/Provisioning Profiles"
        source = Dir.glob("**/*.mobileprovision")

        # Remove all profiles
        FileUtils.rm_rf Dir.glob("#{profiles_dir}/*")
        # Copy new profiles
        FileUtils.cp_r source, "#{profiles_dir}", remove_destination: true
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Copies recursively all provisioning profiles from current folder to system Provisioning Profiles"
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
