# frozen_string_literal: true

module RmsWebService
  module Client
    class Cabinet < Base
      Endpoint = "https://api.rms.rakuten.co.jp/es/1.0/"

      def file_insert(args)
        file = args.delete(:file)
        xml = convert_xml(fileInsertRequest: { file: args })
        payload = {
          xml: xml,
          file: file,
        }
        request = multipart_connection("cabinet/file/insert").post("", payload)
        ::RWS::Response::Cabinet::File::Insert.new(request.body)
      end

      def file_delete(file_id)
        xml = convert_xml(fileDeleteRequest: { file: { fileId: file_id } })
        request = connection("cabinet/file/delete").post { |req| req.body = xml }
        ::RWS::Response::Cabinet::File::Delete.new(request.body)
      end

      def usage_get
        request = connection("cabinet/usage/get").get
        ::RWS::Response::Cabinet::Usage::Get.new(request.body)
      end
      alias :usage :usage_get

      def folders_get(offset: 1, limit: 100)
        request = connection("cabinet/folders/get").get do |req|
          req.params[:offset] = offset
          req.params[:limit] = limit
        end
        ::RWS::Response::Cabinet::Folders::Get.new(request.body)
      end
      alias :folders :folders_get
    end
  end
end
