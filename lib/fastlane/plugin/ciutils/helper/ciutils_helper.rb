module Fastlane
  module Helper
    class CiutilsHelper
      # class methods that you define here become available in your action
      # as `Helper::CiutilsHelper.en_keychain_name`
      #
      def self.en_keychain_name(keychain_name)
        keychain_new_name = File.expand_path("~/Library/Keychains/#{keychain_name}")

        ["", ".keychain", ".keychain-db", "-db"].each do |ext|
          file_path = "#{keychain_new_name}#{ext}"
          if File.exist?(file_path)
            return "#{keychain_name}#{ext}"
          end
        end

        ""
      end

      def self.en_ci_build_number()
        ['BUILD_NUMBER', 'CIRCLE_BUILD_NUM', 'APPCENTER_BUILD_ID', 'TEAMCITY_VERSION', 
          'GO_PIPELINE_NAME', 'bamboo_buildNumber', 'CI_BUILD_ID', 'CI_JOB_ID',
          'XCS_INTEGRATION_NUMBER', 'BITBUCKET_BUILD_NUMBER', 'BUDDYBUILD_BUILD_NUMBER',
          'TRAVIS_BUILD_NUMBER'].each do |current|
          return ENV[current] if ENV.key?(current)
        end
        return "1"
      end
    end
  end
end
