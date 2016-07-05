require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Response::Navigation::Genre::Get do
  let(:api) {described_class.new(fixture('navigation/genre/get.xml'))}

  describe 'attributes' do
    it 'should respond to SystemResult' do
      expect(api).to respond_to :system_status
      expect(api.system_status.message).to eq "OK"
    end

    it 'should respond to NavigationGenreGetResult' do
      expect(api).to respond_to :status
      expect(api).to respond_to :success?
    end

    it 'should respond to File' do
      expect(api).to respond_to :genre
    end
  end
end
