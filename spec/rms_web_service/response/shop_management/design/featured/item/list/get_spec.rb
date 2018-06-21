# frozen_string_literal: true

require "spec_helper"
require "rms_web_service"

describe RmsWebService::Response::ShopManagement::Design::Featured::Item::List::Get do
  let(:api) { described_class.new(fixture("shopmngt/design/featured/item/list/get.xml")) }

  describe "attributes" do
    it "should respond to SystemResult" do
      expect(api).to respond_to :system_status
      expect(api.system_status.message).to eq "OK"
    end

    it "should respond to ShopManagement::Design::Featured::Item::List::Get" do
      expect(api).to respond_to :system_status
      expect(api).to respond_to :success?
    end

    it "should respond to File" do
      expect(api).to respond_to :layout_loss_leader_list
    end
  end
end
