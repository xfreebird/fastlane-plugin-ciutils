module Fastlane
  module Actions
    module SharedValues
      EN_KEYCHAIN_NAME = :EN_KEYCHAIN_NAME
    end

    class EnSetupKeychainAction < Action
      def self.run(params)
        keychain_name = params[:name]
        keychain_password = "password"

        self.remove_keychain_if_exists(keychain_name)

        other_action.create_keychain(
          name: keychain_name,
          default_keychain: false,
          unlock: true,
          timeout: 9600,
          lock_when_sleeps: false,
          password: keychain_password
        )

        # set shared var
        current_keychain_name = Helper::CiutilsHelper.en_keychain_name(keychain_name)
        Actions.lane_context[SharedValues::EN_KEYCHAIN_NAME] = current_keychain_name

        other_action.import_certificate(
          keychain_name: current_keychain_name,
          keychain_password: keychain_password,
          certificate_path: params[:certp12_path],
          certificate_password: params[:certp12_password]
        )
      end

      def self.remove_keychain_if_exists(keychain_name)
        # set shared var
        
        puts "Removing #{keychain_name}"
        current_keychain_name = Helper::CiutilsHelper.en_keychain_name(keychain_name)
        Actions.lane_context[SharedValues::EN_KEYCHAIN_NAME] = current_keychain_name

        puts "Actually Removing #{current_keychain_name}"

        other_action.en_remove_keychain
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Creates the keychain, and imports the provided certificate"
      end

      def self.details
        "The default value for the keychain name is 'fastlane'.
It removes the keychain if exists.
The certificate path should be relative to fastlane folder or full path"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :name,
                                       env_name: "EN_KEYCHAIN_NAME",
                                       description: "Keychain name",
                                       is_string: true, # true: verifies the input is a string, false: every kind of value
                                       default_value: "fastlane"), # the default value if the user didn't provide one
          FastlaneCore::ConfigItem.new(key: :certp12_path,
                                       env_name: "EN_CERTP12_PATH",
                                       description: "Certificate to import",
                                       is_string: true, # true: verifies the input is a string, false: every kind of value
                                       default_value: "cert.p12"), # the default value if the user didn't provide one
          FastlaneCore::ConfigItem.new(key: :certp12_password,
                                       env_name: "EN_CERTP12_PASSWORD",
                                       description: "Password of the Certificate to import. Should be relative to the fastlane folder, or full path",
                                       is_string: true, # true: verifies the input is a string, false: every kind of value
                                       default_value: "password") # the default value if the user didn't provide one
        ]
      end

      def self.output
        [
          ['EN_KEYCHAIN_NAME', 'The name of the created keychain']
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
