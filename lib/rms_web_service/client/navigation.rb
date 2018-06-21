require 'faraday'
require 'active_support'
require 'active_support/core_ext'

module RmsWebService
  module Client
    class Navigation 
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

      def genre_get(genre_id)
        request = connection("navigation/genre/get").get {|req| req.params["genreId"] = genre_id}
        ::RWS::Response::Navigation::Genre::Get.new(request.body)
      end
    end
  end
end
