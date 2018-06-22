# frozen_string_literal: true

require "spec_helper"

describe RmsWebService::Response::Cabinet::Folders::Get do
  let(:api) { described_class.new(fixture("cabinet/folder/get.xml")) }

  describe "attributes" do
    it "should respond to SystemResult" do
      expect(api).to respond_to :status
    end

    it "should respond to resultCode" do
      expect(api).to respond_to :result_code
      expect(api).to respond_to :success?
    end

    it "should respond to folderAllCount" do
      expect(api).to respond_to :folder_all_count
    end

    it "should respond to folderCount" do
      expect(api).to respond_to :folder_count
    end

    describe "#folders" do
      subject { api.folders }

      it { is_expected.to be_a(Array) }
      it { is_expected.to all(be_a(Hash)) }

      context "result value 1 folder only" do
        let(:api) { described_class.new(fixture("cabinet/folder/get_one_folder.xml")) }

        it { is_expected.to be_a(Array) }
        it { is_expected.not_to be_empty }
        it { is_expected.to all(be_a(Hash)) }
        it { is_expected.to all(have_key(:folder_node)) }
        it { is_expected.to all(have_key(:folder_id)) }
      end
    end
  end
end
