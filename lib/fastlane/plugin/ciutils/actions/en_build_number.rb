module Fastlane
  module Actions
    class EnBuildNumberAction < Action
      def self.run(params)
        return Helper::CiutilsHelper.en_ci_build_number()
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Get the value for build number from environment"
      end

      def self.return_value
        "Returns the value of env BUILD_NUMBER, else returns 1. Value is string"
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Nicolae Ghimbovschi"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
