module Fastlane
  module Actions
    class EnCiUtilsInitAction < Action
      def self.run(params)
        output_path = "./build"
        reports_path = "#{output_path}/reports"
        logs_path = "#{output_path}/logs"

        ENV['ENCI_OUTPUT_PATH'] = output_path
        ENV['ENCI_REPORTS_PATH'] = reports_path
        ENV['ENCI_LOGS_PATH'] = logs_path

        # gym: ipa
        ENV['GYM_OUTPUT_DIRECTORY'] = output_path
        ENV['GYM_BUILDLOG_PATH'] = "#{logs_path}/gym"
        ENV['GYM_RESULT_BUNDLE'] = "true"
        ENV['GYM_DERIVED_DATA_PATH'] = "#{output_path}/deriveddata_gym"

        # scan: unit tests
        ENV['SCAN_OUTPUT_DIRECTORY'] = "#{reports_path}/unittests"
        ENV['SCAN_BUILDLOG_PATH'] = "#{logs_path}/scan/"
        ENV['SCAN_DERIVED_DATA_PATH'] = "#{output_path}/deriveddata_scan"
        ENV['SCAN_OUTPUT_TYPES'] = "html,junit,json-compilation-database"
        ENV['SCAN_CONFIGURATION'] = "Debug"
        ENV['SCAN_XCARGS'] = "COMPILER_INDEX_STORE_ENABLE=NO"

        # slather: code coverage reports
        ENV['FL_SLATHER_BUILD_DIRECTORY'] = "#{output_path}/deriveddata_scan"
        ENV['FL_SLATHER_OUTPUT_DIRECTORY'] = "#{reports_path}"
        ENV['FL_SLATHER_COBERTURA_XML_ENABLED'] = "true"
        ENV['FL_SLATHER_USE_BUNDLE_EXEC'] = "true"
        ENV['FL_SLATHER_HTML_ENABLED'] = "false"
        ENV['FL_SLATHER_INPUT_FORMAT'] = "profdata"
        ENV['FL_SLATHER_CONFIGURATION'] = "Debug"

        # swiftlint: static code analysis and linter
        ENV['FL_SWIFTLINT_OUTPUT'] = "#{reports_path}/swiftlint.txt"

        # lizard: static code analysis and linter
        ENV['FL_LIZARD_OUTPUT'] = "#{reports_path}/lizard-report.xml"

        # oclint: static code analysis and linter
        ENV['FL_OCLINT_REPORT_TYPE'] = "pmd"
        ENV['FL_OCLINT_ENABLE_CLANG_STATIC_ANALYZER'] = "true"

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
