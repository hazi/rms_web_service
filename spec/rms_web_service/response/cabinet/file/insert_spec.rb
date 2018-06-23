# frozen_string_literal: true

require "spec_helper"

describe RmsWebService::Response::Cabinet::File::Insert do
  let(:api) { described_class.new(fixture("cabinet/file/insert.xml")) }

  describe "attributes" do
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

    it "should respond to File" do
      expect(api).to respond_to :file_id
    end
  end
end
