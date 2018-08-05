describe Fastlane::Actions::CiutilsAction do
  describe '#run' do
    it 'env variables set correctly' do
      Fastlane::Actions::CiutilsAction.run(nil)
      expect(ENV['ENCI_OUTPUT_PATH']).to eq("./build")
    end
  end
end
