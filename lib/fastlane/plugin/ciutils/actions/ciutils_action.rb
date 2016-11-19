module Fastlane
  module Actions
    class CiutilsAction < Action
      def self.run(params)
        # gym evn variables
        ENV['GYM_OUTPUT_DIRECTORY'] = "build"
        ENV['GYM_BUILDLOG_PATH'] = "build/logs/gym"

        # scan evn variables
        ENV['SCAN_OUTPUT_DIRECTORY'] = "build/reports/"
        ENV['SCAN_BUILDLOG_PATH'] = "build/logs/scan/"
        ENV['SCAN_DERIVED_DATA_PATH'] = "build/deriveddata"

        ENV['FL_SLATHER_BUILD_DIRECTORY'] = "build"
        ENV['FL_SLATHER_OUTPUT_DIRECTORY'] = "build/reports"
        ENV['FL_SLATHER_INPUT_FORMAT'] = "profdata"
        ENV['FL_SLATHER_COBERTURA_XML_ENABLED'] = "true"

        # swiftlint
        ENV['FL_SWIFTLINT_OUTPUT'] = "./build/reports/swiftlint.txt"

        # lizard
        ENV['FL_LIZARD_OUTPUT'] = "../build/reports/lizard-report.xml"
      end

      def self.description
        "Sets env variables for gym, scan, swiftlint and lizard actions"
      end

      def self.authors
        ["Nicolae Ghimbovschi"]
      end

      def self.details
        "Call this action to pre-set gym, scan, swiftlint and lizard to use the build folder for intermediate files and reports"
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
