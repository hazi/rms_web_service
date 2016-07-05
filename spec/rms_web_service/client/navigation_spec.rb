require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Client::Navigation do
  subject(:client) {described_class.new(:service_secret => service_secret, :license_key => license_key)}
  let(:service_secret) {'dummy_service_secret'}
  let(:license_key) {'dummy_license_key'}
  let(:default_url) {"https://api.rms.rakuten.co.jp/es/1.0/"}
  let(:specified_url) {"https://example.com/"}

  describe '.new' do
    it { is_expected.to be_a RmsWebService::Client::Navigation }
  end

  describe '.configuration' do
    subject {client.configuration}
    it { is_expected.to be_a RmsWebService::Configuration }
  end

  describe '.connection' do
    subject {client.connection("item/get")}
    it { is_expected.to be_a Faraday::Connection }
  end

  describe '.endpoint' do
    context 'default URL' do
      subject {client.endpoint("navigation/genre/get")}
      it { is_expected.to eq default_url + "navigation/genre/get"}
    end
    context 'specify URL' do
      let(:api) {described_class.new(:service_secret => service_secret, :license_key => license_key, :endpoint => specified_url)}
      subject {api.endpoint("navigation/genre/get")}
      it { is_expected.to eq specified_url}
    end
  end

  describe '.genre_get' do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/navigation/genre/get?genreId=12345")
      .to_return(:status => 200, body: fixture('navigation/genre/get.xml'))
    end
    subject {client.genre_get("12345")}
    it {is_expected.to be_a RWS::Response::Navigation::Genre::Get}
  end
end
