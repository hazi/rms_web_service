#encoding: utf-8
# frozen_string_literal: true

require "spec_helper"
require "rms_web_service"

describe RWS::Response::Item::Error do
  let(:res) do
    { "error_id"=>"errorId", "field_id"=>"503", "msg"=>"error message", "list_index"=>"1",
      "list_index2"=>"2", "field"=>"item_price", "field_name"=>"販売価格" }
  end

  subject { described_class.parse(fixture("item/update.xml").read) }
  it("should return formatted error") { is_expected.to eq res }

  describe "optional attributes" do
    it { is_expected.to include("field") }
    it { is_expected.to include("field_name") }
  end

  describe "invalid argument" do
    it "" do
      expect { described_class.parse(Array.new) }.to raise_error ArgumentError
    end
  end
end
