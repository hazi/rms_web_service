# frozen_string_literal: true

require "spec_helper"

describe RmsWebService::Client::Cabinet do
  subject(:client) { described_class.new(service_secret: service_secret, license_key: license_key) }
  let(:service_secret) { "dummy_service_secret" }
  let(:license_key) { "dummy_license_key" }
  let(:default_url) { "https://api.rms.rakuten.co.jp/es/1.0/" }
  let(:specified_url) { "https://example.com/" }

  describe ".new" do
    it { is_expected.to be_a RmsWebService::Client::Cabinet }
  end

  describe "#configuration" do
    subject { client.configuration }
    it { is_expected.to be_a RmsWebService::Configuration }
  end

  describe "#connection" do
    subject { client.connection("item/get") }
    it { is_expected.to be_a Faraday::Connection }
  end

  describe "#endpoint" do
    context "default URL" do
      subject { client.endpoint("cabinet/file/insert") }
      it { is_expected.to eq default_url + "cabinet/file/insert" }
    end
    context "specify URL" do
      let(:api) do
        described_class.new(service_secret: service_secret, license_key: license_key, endpoint: specified_url)
      end

      subject { api.endpoint("cabinet/file/insert") }
      it { is_expected.to eq specified_url }
    end
  end

  describe "#file_insert" do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/file/insert")
      .to_return(status: 200, body: fixture("cabinet/file/insert.xml"))
    end
    subject { client.file_insert({}) }
    it { is_expected.to be_a RWS::Response::Cabinet::File::Insert }
  end

  describe "#file_delete" do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/file/delete")
      .to_return(status: 200, body: fixture("cabinet/file/delete.xml"))
    end
    subject { client.file_delete({}) }
    it { is_expected.to be_a RWS::Response::Cabinet::File::Delete }
  end

  describe "#usage_get" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/usage/get")
      .to_return(status: 200, body: fixture("cabinet/usage/get.xml"))
    end
    subject { client.usage_get }
    it { is_expected.to be_a RWS::Response::Cabinet::Usage::Get }
  end

  describe "#usage" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/usage/get")
      .to_return(status: 200, body: fixture("cabinet/usage/get.xml"))
    end
    subject { client.usage }
    it { is_expected.to be_a RWS::Response::Cabinet::Usage::Get }
  end

  describe "#folders_get" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/folders/get?limit=100&offset=1")
      .to_return(status: 200, body: fixture("cabinet/folders/get.xml"))
    end
    subject { client.folders_get }
    it { is_expected.to be_a RWS::Response::Cabinet::Folders::Get }
  end

  describe "#folders" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/folders/get?limit=100&offset=1")
      .to_return(status: 200, body: fixture("cabinet/folders/get.xml"))
    end
    subject { client.folders }
    it { is_expected.to be_a RWS::Response::Cabinet::Folders::Get }
  end
end
