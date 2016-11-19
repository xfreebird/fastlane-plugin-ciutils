module Fastlane
  module Actions
    class EnCloseSimulatorAction < Action
      def self.run(params)
        Fastlane::Actions.sh("osascript -e 'tell app \"Simulator\" to quit'", log: false)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Closes all simulator instances"
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
