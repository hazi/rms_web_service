require "faraday"
require "active_support"
require "active_support/core_ext"

module RmsWebService
  module Client
    class ShopManagement
      Endpoint = "https://api.rms.rakuten.co.jp/es/1.0/"
      attr_accessor :configuration

      def initialize(args={})
        @configuration = ::RmsWebService::Configuration.new(args)
        @endpoint = args[:endpoint]
      end

      def connection(method)
        Faraday.new(url: endpoint(method)) do |c|
          c.adapter Faraday.default_adapter
          c.headers["Authorization"] = self.configuration.encoded_keys
        end
      end

      def multipart_connection(method)
        Faraday.new(url: endpoint(method)) do |c|
          c.request :multipart
          c.request :url_encoded
          c.adapter Faraday.default_adapter
          c.headers["Authorization"] = self.configuration.encoded_keys
        end
      end

      def endpoint(method)
        @endpoint || Endpoint + method
      end

      def dsgn_navitemplate_list_get(opt={})
        request = connection("shopmngt/design/navitemplate/list/get").get do |req|
          req.params["layoutCommonId"] = opt[:layout_common_id] if opt.key?(:layout_common_id)
        end
        ::RWS::Response::ShopManagement::Design::NaviTemplate::List::Get.new(request.body)
      end

      def dsgn_featured_item_list_get(opt={})
        request = connection("shopmngt/design/featured/item/list/get").get do |req|
          req.params["lossLeaderId"] = opt[:loss_leader_id] if opt.key?(:loss_leader_id)
        end
        ::RWS::Response::ShopManagement::Design::Featured::Item::List::Get.new(request.body)
      end

      def dsgn_description_s_list_get(opt={})
        request = connection("shopmngt/design/description/small/list/get").get do |req|
          req.params["textSmallId"] = opt[:text_small_id] if opt.key?(:text_small_id)
        end
        ::RWS::Response::ShopManagement::Design::Description::Small::List::Get.new(request.body)
      end

      def dsgn_description_l_list_get(opt={})
        request = connection("shopmngt/design/description/large/list/get").get do |req|
          req.params["textLargeId"] = opt[:text_large_id] if opt.key?(:text_large_id)
        end
        ::RWS::Response::ShopManagement::Design::Description::Large::List::Get.new(request.body)
      end
    end
  end
end
