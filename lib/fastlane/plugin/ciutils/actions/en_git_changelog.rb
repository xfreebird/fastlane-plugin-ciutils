module Fastlane
  module Actions
    class EnGitChangelogAction < Action
      def self.run(params)
        from_commit = params[:from_commit]
        to_commit = params[:to_commit]
        filter = params[:filter]

        change_log = self.git_log_between(from_commit, to_commit, filter)
        self.inject_env_with_changelog(change_log)
        change_log
      end

      def self.git_log_between(from_commit, to_commit, filter)
        change_log = `git log #{from_commit}...#{to_commit} --no-merges | grep #{filter} | sed -e 's/^[[:space:]]*//' | sed 's/\\[//'| sed 's/\\]//' | sort -r -u`
        change_log
      end

      def self.inject_env_with_changelog(change_log)
        ENV['EN_CHANGELOG'] = change_log
        ENV['FL_HOCKEY_NOTES'] = change_log
        ENV['PILOT_CHANGELOG'] = change_log
        ENV['CRASHLYTICS_NOTES'] = change_log
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Creates a change log from git commits by filtering commits by a pattern (e.g. JIRA task prefix)"
      end

      def self.details
        "You can use this action to do create a git changelog with tasks id.
It also sets the result to EN_CHANGELOG, FL_HOCKEY_NOTES, PILOT_CHANGELOG and CRASHLYTICS_NOTES"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :from_commit,
                                       env_name: "FL_EN_GIT_FROM_COMMIT",
                                       description: "Commit from where to start the log. Default value is ENV['GIT_PREVIOUS_SUCCESSFUL_COMMIT']",
                                       default_value: ENV['GIT_PREVIOUS_SUCCESSFUL_COMMIT']),
          FastlaneCore::ConfigItem.new(key: :to_commit,
                                       env_name: "FL_EN_GIT_TO_COMMIT",
                                       description: "The last commit included in the log. Default value is ENV['GIT_COMMIT']",
                                       default_value: ENV['GIT_COMMIT']),
          FastlaneCore::ConfigItem.new(key: :filter,
                                       env_name: "FL_EN_TASK_PREFIX_FILTER",
                                       description: "The prefix/string to look in the commit message (e.g. JIRA task prefix)")
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
