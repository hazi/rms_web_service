# frozen_string_literal: true

require "spec_helper"
require "rms_web_service"

describe RmsWebService::Client::Category do
  subject(:client) { described_class.new(service_secret: service_secret, license_key: license_key) }
  let(:service_secret) { "dummy_service_secret" }
  let(:license_key) { "dummy_license_key" }
  let(:default_url) { "https://api.rms.rakuten.co.jp/es/1.0/" }
  let(:specified_url) { "https://example.com/" }

  describe ".new" do
    it { is_expected.to be_a RmsWebService::Client::Category }
  end

  describe ".configuration" do
    subject { client.configuration }
    it { is_expected.to be_a RmsWebService::Configuration }
  end

  describe ".connection" do
    subject { client.connection("categoryapi/shop/categories/get") }
    it { is_expected.to be_a Faraday::Connection }
  end

  describe ".endpoint" do
    context "default URL" do
      subject { client.endpoint("categoryapi/shop/categories/get") }
      it { is_expected.to eq default_url + "categoryapi/shop/categories/get" }
    end
    context "specify URL" do
      let(:api) do
        described_class.new(service_secret: service_secret, license_key: license_key, endpoint: specified_url)
      end
      subject { api.endpoint("categoryapi/shop/categories/get") }
      it { is_expected.to eq specified_url }
    end
  end

  describe ".genre_get" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/categoryapi/shop/categories/get")
      .to_return(status: 200, body: fixture("category/shop/categories/get.xml"))
    end
    subject { client.shop_categories_get() }
    it { is_expected.to be_a RWS::Response::Category::Shop::Categories::Get }
  end
end
