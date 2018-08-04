describe Fastlane::Actions::CiutilsAction do
  describe '#run' do
    it 'env variables set correctly' do
      Fastlane::Actions::CiutilsAction.run(nil)
      expect(ENV['GYM_OUTPUT_DIRECTORY']).to eq("build")
      expect(ENV['GYM_BUILDLOG_PATH']).to eq("build/logs/gym")

      expect(ENV['SCAN_OUTPUT_DIRECTORY']).to eq("build/reports/unittests")
      expect(ENV['SCAN_BUILDLOG_PATH']).to eq("build/logs/scan/")
      expect(ENV['SCAN_DERIVED_DATA_PATH']).to eq("build/deriveddata")

      expect(ENV['FL_SLATHER_OUTPUT_DIRECTORY']).to eq("build/reports")
      expect(ENV['FL_SLATHER_COBERTURA_XML_ENABLED']).to eq("true")
    end
  end
end
