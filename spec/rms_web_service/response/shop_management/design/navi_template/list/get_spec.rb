# frozen_string_literal: true

require "spec_helper"

describe RmsWebService::Response::ShopManagement::Design::NaviTemplate::List::Get do
  let(:api) { described_class.new(fixture("shopmngt/design/navitemplate/list/get.xml")) }

  describe "attributes" do
    it "should respond to SystemResult" do
      expect(api).to respond_to :system_status
      expect(api.system_status.message).to eq "OK"
    end

    it "should respond to ShopManagement::Design::NaviTemplate::List::Get" do
      expect(api).to respond_to :system_status
      expect(api).to respond_to :success?
    end

    it "should respond to File" do
      expect(api).to respond_to :shop_layout_common_list
    end
  end
end
