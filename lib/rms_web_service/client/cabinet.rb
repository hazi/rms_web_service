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
    end
  end
end
