module Fastlane
  module Actions
    module SharedValues
    end

    class EnRemoveKeychainAction < Action
      def self.run(params)
        # add original keychain to list
        original = Actions.lane_context[Actions::SharedValues::ORIGINAL_DEFAULT_KEYCHAIN]
        Fastlane::Actions.sh("security list-keychains -s #{original}", log: false) unless original.nil?

        begin
          keychain_name = Actions.lane_context[SharedValues::EN_KEYCHAIN_NAME]
          other_action.delete_keychain(name: keychain_name)
        rescue
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Removes the keychain setup by en_setup_keychain"
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
