module Fastlane
  module Actions
    module SharedValues
    end

    class EnRemoveKeychainAction < Action
      def self.run(params)
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
