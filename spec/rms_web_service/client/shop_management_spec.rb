require 'spec_helper'
require 'rms_web_service'

describe RmsWebService::Client::ShopManagement do
  subject(:client) {described_class.new(:service_secret => service_secret, :license_key => license_key)}
  let(:service_secret) {'dummy_service_secret'}
  let(:license_key) {'dummy_license_key'}
  let(:default_url) {"https://api.rms.rakuten.co.jp/es/1.0/"}
  let(:specified_url) {"https://example.com/"}

  describe '.new' do
    it { is_expected.to be_a RmsWebService::Client::ShopManagement }
  end

  describe '.configuration' do
    subject {client.configuration}
    it { is_expected.to be_a RmsWebService::Configuration }
  end

  describe '.connection' do
    subject {client.connection("navigation/genre/get")}
    it { is_expected.to be_a Faraday::Connection }
  end

  describe '.endpoint' do
    context 'default URL' do
      subject {client.endpoint("shopmngt/design/navi_template/list/get")}
      it { is_expected.to eq default_url + "shopmngt/design/navi_template/list/get"}
    end
    context 'specify URL' do
      let(:api) {described_class.new(:service_secret => service_secret, :license_key => license_key, :endpoint => specified_url)}
      subject {api.endpoint("shopmngt/design/navi_template/list/get")}
      it { is_expected.to eq specified_url}
    end
  end

  describe '.dsgn_navitemplate_list_get' do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/shopmngt/design/navitemplate/list/get")
      .to_return(:status => 200, body: fixture('shopmngt/design/navitemplate/list/get.xml'))
    end
    subject {client.dsgn_navitemplate_list_get()}
    it {is_expected.to be_a RWS::Response::ShopManagement::Design::NaviTemplate::List::Get}
  end

  describe '.dsgn_featured_item_list_get' do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/shopmngt/design/featured/item/list/get")
      .to_return(:status => 200, body: fixture('shopmngt/design/featured/item/list/get.xml'))
    end
    subject {client.dsgn_featured_item_list_get()}
    it {is_expected.to be_a RWS::Response::ShopManagement::Design::Featured::Item::List::Get}
  end

  describe '.dsgn_description_s_list_get' do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/shopmngt/design/description/small/list/get")
      .to_return(:status => 200, body: fixture('shopmngt/design/description/small/list/get.xml'))
    end
    subject {client.dsgn_description_s_list_get()}
    it {is_expected.to be_a RWS::Response::ShopManagement::Design::Description::Small::List::Get}
  end

  describe '.dsgn_description_l_list_get' do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/shopmngt/design/description/large/list/get")
      .to_return(:status => 200, body: fixture('shopmngt/design/description/large/list/get.xml'))
    end
    subject {client.dsgn_description_l_list_get()}
    it {is_expected.to be_a RWS::Response::ShopManagement::Design::Description::Large::List::Get}
  end
end
