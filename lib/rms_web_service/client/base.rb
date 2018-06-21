require "faraday"
require "active_support"
require "active_support/core_ext"

module RmsWebService
  module Client
    class Base
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

      def convert_xml(hash)
        hash.to_xml(root: "request", camelize: :lower, skip_types: true)
      end

      def endpoint(method)
        @endpoint || self.class::Endpoint + method
      end
    end
  end
end
