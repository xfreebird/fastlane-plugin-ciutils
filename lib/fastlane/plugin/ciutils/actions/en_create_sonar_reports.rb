module Fastlane
  module Actions
    class EnCreateSonarReportsAction < Action
      def self.run(params)
        build_path = ENV['ENCI_OUTPUT_PATH']
        reports_path = ENV['ENCI_REPORTS_PATH']
        logs_path = ENV['ENCI_LOGS_PATH']
        scan_logs_path = ENV['SCAN_BUILDLOG_PATH']
        scan_reports_path = ENV['SCAN_OUTPUT_DIRECTORY']

        lizard_output_path = ENV['FL_LIZARD_OUTPUT']
        swiftlint_output_path = ENV['FL_SWIFTLINT_OUTPUT']

        lizard_extra_args = params[:lizard_extra_args]
        swiftlint_extra_args = params[:swiftlint_extra_args]

        swiftlint_path_args = self.swiftlint_path_args(params)
        lizard_path_args = self.lizard_path_args(params)

        unless File.exist?(scan_reports_path)
          UI.user_error!("Please run scan and slather first.")
          return
        end

        FileUtils::mkdir_p(reports_path) unless File.exists?(reports_path)

        # create the junit reports again in such way that can be used by sonar
        sh("cat '#{scan_logs_path}'/*.log | bundle exec ocunit2junit > /dev/null 2>&1 || exit 0")

        # ocunit2junit creates the reports in local test-reports, it needs to be moved
        FileUtils::rm_rf("#{scan_reports_path}/test-reports")
        FileUtils::mv("test-reports", "#{scan_reports_path}")

        if Dir.glob("#{scan_reports_path}/test-reports/*.xml").empty?
          # ocunit2junit failed?
          UI.message("ocunit2junit failed, copying the original junit report to test-reports")
          FileUtils::cp("#{scan_reports_path}/report.junit", "#{scan_reports_path}/test-reports/report.xml")
        end

        # run static code analysis
        unless params[:skip_swiftlint_analysis]
          sh("swiftlint lint #{swiftlint_path_args} --quiet > '#{swiftlint_output_path}' || exit 0")
        end

        unless params[:skip_lizard_analysis]
          sh("lizard #{lizard_path_args} -l swift -l objectivec --xml #{lizard_extra_args} > '#{lizard_output_path}' || exit 0")
        end

        # workaround sonar plugin, it is not picking correctly the path to lizard report
        # and it is looking at the default path
        FileUtils::ln_sf(reports_path, "sonar-reports")

        unless params[:skip_oclint_analysis]
          scan_json_compilation_database = File.expand_path(scan_reports_path) + '/report.json-compilation-database'
          json_compilation_database = File.expand_path(scan_reports_path) + '/compile_commands.json'
          FileUtils::cp("#{scan_reports_path}/report.json-compilation-database", json_compilation_database)
          other_action.oclint(compile_commands: scan_json_compilation_database)
          FileUtils::mv("./fastlane/oclint_report.pmd", "#{reports_path}/oclint.xml")
        end
      end

      def self.normalize_paths(paths)
        paths.split(",").map { |path| File.expand_path(path.strip) }
      end

      def self.lizard_path_args(params)
        include_files = ""

        if params[:include_path]
          self.normalize_paths(params[:include_path]).each do |path|
            include_files += " '#{path}' " 
          end
        end

        exclude_files = ""
        if params[:exclude_path]
          self.normalize_paths(params[:exclude_path]).each do |path|
            exclude_files += " -x '#{path}/*' "
          end
        end

        include_files + exclude_files
      end

      def self.swiftlint_path_args(params)
        include_files = ""

        if params[:include_path]
          self.normalize_paths(params[:include_path]).each do |path|
            include_files += " --path '#{path}'"
          end
        end

        # exclude_files = ""
        # if params[:exclude_path]
        #   self.normalize_paths(params[:exclude_path]).each do |path|
        #     exclude_files += " --force-exclude '#{path}' "
        #   end
        # end

        # include_files + exclude_files
        include_files
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :include_path,
                                       env_name: "FL_EN_ANALYSIS_INCLUDE_SRC",
                                       description: 'One or multiple paths comma separated to include into scan report',
                                       optional: false),

          FastlaneCore::ConfigItem.new(key: :exclude_path,
                                       env_name: "FL_EN_ANALYSIS_EXCLUDE_SRC",
                                       description: 'One or multiple paths comma separated to include into scan report',
                                       optional: true),

          FastlaneCore::ConfigItem.new(key: :skip_oclint_analysis,
                                       env_name: "FL_EN_SKIP_OCLINT_ANALYSIS",
                                       description: "Skip running oclint code analysis",
                                       is_string: false,
                                       default_value: false,
                                       optional: true),

          FastlaneCore::ConfigItem.new(key: :skip_swiftlint_analysis,
                                       env_name: "FL_EN_SKIP_SWIFTLINT_ANALYSIS",
                                       description: "Skip running swiftlint code analysis",
                                       is_string: false,
                                       default_value: false,
                                       optional: true),

          FastlaneCore::ConfigItem.new(key: :swiftlint_extra_args,
                                       env_name: "FL_EN_SWIFTLINT_EXTRA ARGS",
                                       description: 'Extra command line args for swiftlint',
                                       optional: true),

          FastlaneCore::ConfigItem.new(key: :skip_lizard_analysis,
                                       env_name: "FL_EN_SKIP_LIZARD_ANALYSIS",
                                       description: "Skip running lizard code analysis",
                                       is_string: false,
                                       default_value: false,
                                       optional: true),

          FastlaneCore::ConfigItem.new(key: :lizard_extra_args,
                                       env_name: "FL_EN_LIZARD_EXTRA ARGS",
                                       description: 'Extra command line args for lizard',
                                       optional: true)
        ]
      end

      def self.description
        "Creates swiftlint, lizard and oclint reports and adjusts junit reports for sonarqube (with the open source swift/objc plugin)"
      end

      def self.details
        "Ensure before calling this action ensure en_ci_utils_init_action, scan and slather were executed.
This action re-uses values for used for scan and env variables set by en_ci_utils_init_action for reports paths.
The oclint command is executed throug the oclint action. You can change input for that action through oclint action env variables.

The exclude files option doesn't work for swiftlint and oclint. You can exclude files in sonar properties or for swiftlint with .swiftlint.yml"
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
