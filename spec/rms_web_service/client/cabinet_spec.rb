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
    let(:file) { double("upload_io") }

    subject { client.file_insert(file: file, file_name: "test.jpg", folder_id: 1) }
    it { is_expected.to be_a RWS::Response::Cabinet::Result }
  end

  describe "#upload" do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/file/insert")
        .to_return(status: 200, body: fixture("cabinet/file/insert.xml"))
    end
    let(:file) { double("upload_io") }

    subject { client.upload(file: file, file_name: "test.jpg", folder_id: 1) }
    it { is_expected.to be_a RWS::Response::Cabinet::Result }
  end

  describe "#file_delete" do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/file/delete")
        .to_return(status: 200, body: fixture("cabinet/file/delete.xml"))
    end
    subject { client.file_delete({}) }
    it { is_expected.to be_a RWS::Response::Cabinet::Result }
  end

  describe "#delete" do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/file/delete")
        .to_return(status: 200, body: fixture("cabinet/file/delete.xml"))
    end
    subject { client.delete({}) }
    it { is_expected.to be_a RWS::Response::Cabinet::Result }
  end

  describe "#usage_get" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/usage/get")
        .to_return(status: 200, body: fixture("cabinet/usage/get.xml"))
    end
    subject { client.usage_get }
    it { is_expected.to be_a RWS::Response::Cabinet::Usage }
  end

  describe "#usage" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/usage/get")
        .to_return(status: 200, body: fixture("cabinet/usage/get.xml"))
    end
    subject { client.usage }
    it { is_expected.to be_a RWS::Response::Cabinet::Usage }
  end

  describe "#folders_get" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/folders/get?limit=100&offset=1")
        .to_return(status: 200, body: fixture("cabinet/folder/get.xml"))
    end
    subject { client.folders_get }
    it { is_expected.to be_a RWS::Response::Cabinet::Folders }
  end

  describe "#folders" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/folders/get?limit=100&offset=1")
        .to_return(status: 200, body: fixture("cabinet/folder/get.xml"))
    end
    subject { client.folders }
    it { is_expected.to be_a RWS::Response::Cabinet::Folders }
  end

  describe "#folder_files_get" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/folder/files/get?folderId=1&limit=100&offset=1")
        .to_return(status: 200, body: fixture("cabinet/folder/files_get.xml"))
    end
    subject { client.folder_files_get(folder_id: 1) }
    it { is_expected.to be_a RWS::Response::Cabinet::Files }
  end

  describe "#folder_files" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/folder/files/get?folderId=1&limit=100&offset=1")
        .to_return(status: 200, body: fixture("cabinet/folder/files_get.xml"))
    end
    subject { client.folder_files(folder_id: 1) }
    it { is_expected.to be_a RWS::Response::Cabinet::Files }
  end

  describe "#files_search" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/files/search?fileName=test")
        .to_return(status: 200, body: fixture("cabinet/file/search.xml"))
    end
    subject { client.files_search(file_name: "test") }
    it { is_expected.to be_a RWS::Response::Cabinet::Files }
  end

  describe "#search" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/files/search?fileName=test")
        .to_return(status: 200, body: fixture("cabinet/file/search.xml"))
    end
    subject { client.search(file_name: "test") }
    it { is_expected.to be_a RWS::Response::Cabinet::Files }
  end

  describe "#trashbox_files_get" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/trashbox/files/get?limit=100&offset=1")
        .to_return(status: 200, body: fixture("cabinet/trashbox/files_get.xml"))
    end
    subject { client.trashbox_files_get }
    it { is_expected.to be_a RWS::Response::Cabinet::Files }
  end

  describe "#trashbox_files" do
    before do
      stub_request(:get, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/trashbox/files/get?limit=100&offset=1")
        .to_return(status: 200, body: fixture("cabinet/trashbox/files_get.xml"))
    end
    subject { client.trashbox_files }
    it { is_expected.to be_a RWS::Response::Cabinet::Files }
  end

  describe "#trashbox_file_revert" do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/trashbox/file/revert")
        .to_return(status: 200, body: fixture("cabinet/trashbox/file_revert.xml"))
    end
    subject { client.trashbox_file_revert(file_id: 1, folder_id: 1) }
    it { is_expected.to be_a RWS::Response::Cabinet::Result }
  end

  describe "#restore" do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/trashbox/file/revert")
        .to_return(status: 200, body: fixture("cabinet/trashbox/file_revert.xml"))
    end
    subject { client.restore(file_id: 1, folder_id: 1) }
    it { is_expected.to be_a RWS::Response::Cabinet::Result }
  end

  describe "#file_update" do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/file/update")
        .to_return(status: 200, body: fixture("cabinet/file/update.xml"))
    end
    subject { client.file_update(file_id: 1, file_name: "new name") }
    it { is_expected.to be_a RWS::Response::Cabinet::Result }
  end

  describe "#folder_insert" do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/folder/insert")
        .to_return(status: 200, body: fixture("cabinet/folder/insert.xml"))
    end
    subject { client.folder_insert(folder_name: "new_folder") }
    it { is_expected.to be_a RWS::Response::Cabinet::Result }
  end

  describe "#create_folder" do
    before do
      stub_request(:post, "https://api.rms.rakuten.co.jp/es/1.0/cabinet/folder/insert")
        .to_return(status: 200, body: fixture("cabinet/folder/insert.xml"))
    end
    subject { client.create_folder(folder_name: "new_folder") }
    it { is_expected.to be_a RWS::Response::Cabinet::Result }
  end
end
