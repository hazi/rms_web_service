# frozen_string_literal: true

require "spec_helper"

describe RmsWebService::Response::Item::Parser do
  describe "initialize" do
    subject { ::RWS::Response::Item::Update.new(fixture("item/update.xml")) }
    it { is_expected.to be_a ::RWS::Response::Item::Parser }
  end

  describe "#errors" do
    subject { api.errors }

    context "error message exists" do
      let(:api) { ::RWS::Response::Item::Update.new(fixture("item/update.xml")) }
      it { is_expected.to be_a Array }
      it { is_expected.to be_present }
    end

    context "no error message" do
      let(:api) { ::RWS::Response::Item::Update.new(fixture("item/get.xml")) }
      it { is_expected.to be_a Array }
      it { is_expected.to be_empty }
    end
  end
end
