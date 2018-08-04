module Fastlane
  module Actions
    class EnCiUtilsInitAction < Action
      def self.run(params)
        # gym evn variables
        ENV['GYM_OUTPUT_DIRECTORY'] = "build"
        ENV['GYM_BUILDLOG_PATH'] = "build/logs/gym"

        # scan env variables
        ENV['SCAN_OUTPUT_DIRECTORY'] = "build/reports/unittests"
        ENV['SCAN_BUILDLOG_PATH'] = "build/logs/scan/"
        ENV['SCAN_DERIVED_DATA_PATH'] = "build/deriveddata"
        ENV['SCAN_OUTPUT_TYPES'] = "html,junit,json-compilation-database"

        ENV['FL_SLATHER_BUILD_DIRECTORY'] = "build/deriveddata"
        ENV['FL_SLATHER_OUTPUT_DIRECTORY'] = "build/reports"
        ENV['FL_SLATHER_COBERTURA_XML_ENABLED'] = "true"
        ENV['FL_SLATHER_USE_BUNDLE_EXEC'] = "true"
        ENV['FL_SLATHER_HTML_ENABLED'] = "false"

        # swiftlint
        ENV['FL_SWIFTLINT_OUTPUT'] = "./build/reports/swiftlint.txt"

        # lizard
        ENV['FL_LIZARD_OUTPUT'] = "../build/reports/lizard-report.xml"

        ENV['BUILD_NUMBER'] = Helper::CiutilsHelper.en_ci_build_number()
        ENV['FL_BUILD_NUMBER_BUILD_NUMBER'] = ENV['BUILD_NUMBER']
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
    class CiutilsAction < EnCiUtilsInitAction
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
