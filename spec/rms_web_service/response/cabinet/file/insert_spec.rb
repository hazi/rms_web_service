# frozen_string_literal: true

require "spec_helper"
require "rms_web_service"

describe RmsWebService::Response::Cabinet::File::Insert do
  let(:api) { described_class.new(fixture("cabinet/file/insert.xml")) }

  describe "attributes" do
    it "should respond to SystemResult" do
      expect(api).to respond_to :status
      expect(api.status.message).to eq "OK"
    end

    it "should respond to CabinetFileInsertResult" do
      expect(api).to respond_to :result_code
      expect(api).to respond_to :success?
    end

    it "should respond to File" do
      expect(api).to respond_to :file_id
    end
  end
end
