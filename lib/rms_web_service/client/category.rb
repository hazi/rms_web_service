require 'faraday'
require 'active_support'
require 'active_support/core_ext'

module RmsWebService
  module Client
    class Category 
      Endpoint = "https://api.rms.rakuten.co.jp/es/1.0/"
      attr_accessor :configuration

      def initialize(args={})
        @configuration = ::RmsWebService::Configuration.new(args)
        @endpoint = args[:endpoint]
      end

      def connection(method)
        Faraday.new(:url => endpoint(method)) do |c|
          c.adapter Faraday.default_adapter
          c.headers['Authorization'] = self.configuration.encoded_keys
        end
      end

      def multipart_connection(method)
        Faraday.new(:url => endpoint(method)) do |c|
          c.request :multipart
          c.request :url_encoded
          c.adapter Faraday.default_adapter
          c.headers['Authorization'] = self.configuration.encoded_keys
        end
      end

      def endpoint(method)
        @endpoint || Endpoint + method
      end

      def shop_categories_get(opt={})
        request = connection("categoryapi/shop/categories/get").get do |req| 
          req.params["categorySetManageNumber"] = opt[:category_set_manage_number] if opt.key(:category_set_manage_number)
        end 
        ::RWS::Response::Category::Shop::Categories::Get.new(request.body)
      end
    end
  end
end
