# frozen_string_literal: true

require "spec_helper"

describe RmsWebService::Response::Cabinet::Result do
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
  end

  context "endpoint cabinet/folder/insert" do
    let(:api) { described_class.new(fixture("cabinet/folder/insert.xml")) }

    include_examples "response cabinet files"

    it "should respond to FolderId" do
      expect(api).to respond_to :folder_id
    end
  end

  context "endpoint cabinet/file/update" do
    let(:api) { described_class.new(fixture("cabinet/file/update.xml")) }

    include_examples "response cabinet files"
  end

  context "endpoint cabinet/trashbox/file/revert" do
    let(:api) { described_class.new(fixture("cabinet/trashbox/file_revert.xml")) }

    include_examples "response cabinet files"
  end
end
