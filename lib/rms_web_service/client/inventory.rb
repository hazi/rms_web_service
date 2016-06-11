require 'faraday'
require 'active_support'
require 'active_support/core_ext'

module RmsWebService
  module Client
    class Inventory 
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

      def endpoint(method)
        @endpoint || Endpoint + method
      end

      def get_inventory_external(args)
        xml = {:getInventoryExternal => {:file => args}}.to_xml(:root => 'request', :camelize => :lower, :skip_types => true)
        request = connection("inventory/get_inventory_external").post {|req| req.body = xml}
        ::RWS::Response::Inventory::GetInventoryExternal.new(request.body)
      end

      def update_inventory_external(args)
        xml = {:updateInventoryExternal => {:file => args}}.to_xml(:root => 'request', :camelize => :lower, :skip_types => true)
        request = connection("inventory/update_inventory_external").post {|req| req.body = xml}
        ::RWS::Response::Inventory::UpdateInventoryExternal.new(request.body)
      end
    end
  end
end
