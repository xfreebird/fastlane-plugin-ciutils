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
    end
  end
end
