require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Response::Item::ItemsUpdate do
  subject(:api) {described_class.new(fixture('item/items_update.xml'))}
  it 'should be an array of RWS::Response::Item::Update' do
    expect(api[0]).to be_a RWS::Response::Item::Update
  end

  describe 'attributes' do
    it 'should respond to SystemResult' do
      expect(api).to respond_to :status
    end

    it 'should not respond to ItemsUpdateResult' do
      expect(api).not_to respond_to :code
      expect(api).not_to respond_to :success?
    end

    it 'should not respond to Item' do
      expect(api).not_to respond_to :item_url
    end

    it 'should not respond to ErrorMessage' do
      expect(api).not_to respond_to :errors
    end
  end
end
