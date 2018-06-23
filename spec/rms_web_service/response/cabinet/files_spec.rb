# frozen_string_literal: true

require "spec_helper"

describe RmsWebService::Response::Cabinet::Files do
  shared_examples "response cabinet files" do
    it "should respond to SystemResult" do
      expect(api).to respond_to :status
      expect(api.status.message).to eq "OK"
      expect(api.status.success?).to eq(true)
    end

    it "should respond to resultCode" do
      expect(api).to respond_to :result_code
    end

    it "should respond to success?" do
      expect(api).to respond_to :success?
      expect(api.success?).to eq(true)
    end

    describe "#files" do
      subject { api.files }

      it { is_expected.to be_a(Array) }
      it { is_expected.not_to be_empty }
      it { is_expected.to all(be_a(Hash)) }
      it { is_expected.to all(have_key(:folder_node)) }
      it { is_expected.to all(have_key(:file_id)) }
    end
  end

  context "endpoint cabinet/folder/files/get" do
    let(:api) { described_class.new(fixture("cabinet/folder/files_get.xml")) }

    include_examples "response cabinet files"
  end

  context "endpoint cabinet/files/search" do
    let(:api) { described_class.new(fixture("cabinet/file/search.xml")) }

    include_examples "response cabinet files"
  end

  context "endpoint cabinet/trashbox/files/get" do
    let(:api) { described_class.new(fixture("cabinet/trashbox/files_get.xml")) }

    include_examples "response cabinet files"
  end
end
