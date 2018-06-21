# frozen_string_literal: true

require "spec_helper"

describe RmsWebService::Response::Cabinet::File::Delete do
  let(:api) { described_class.new(fixture("cabinet/file/delete.xml")) }

  describe "attributes" do
    it "should respond to SystemResult" do
      expect(api).to respond_to :status
    end

    it "should respond to CabinetFileDeleteResult" do
      expect(api).to respond_to :result_code
      expect(api).to respond_to :success?
    end
  end
end
