require 'faraday'
require 'active_support'
require 'active_support/core_ext'

module RmsWebService
  module Client
    class Cabinet
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

      def file_insert(args)
        file = args.delete(:file)
        xml = {:fileInsertRequest => {:file => args}}.to_xml(:root => 'request', :camelize => :lower, :skip_types => true)
        payload = {
          :xml => xml,
          :file => file, 
        }
        request = multipart_connection("cabinet/file/insert").post("", payload)
        ::RWS::Response::Cabinet::File::Insert.new(request.body)
      end

      def file_delete(file_id)
        xml = {:fileDeleteRequest => {:file => { :fileId => file_id }}}.to_xml(:root => 'request', :camelize => :lower, :skip_types => true)
        request = connection("cabinet/file/delete").post {|req| req.body = xml}
        ::RWS::Response::Cabinet::File::Delete.new(request.body)
      end
    end
  end
end
