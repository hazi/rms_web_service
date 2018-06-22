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

      def folder_files_get(folder_id:, offset: 1, limit: 100)
        request = connection("cabinet/folder/files/get").get do |req|
          req.params[:folderId] = folder_id
          req.params[:offset] = offset
          req.params[:limit] = limit
        end
        ::RWS::Response::Cabinet::Files.new(request.body)
      end
      alias :folder_files :folder_files_get

      def files_search(args)
        request = connection("cabinet/files/search").get do |req|
          params = args.deep_transform_keys { |key| key.to_s.camelcase.sub(/^./, &:downcase) }
          req.params.update(params)
        end
        ::RWS::Response::Cabinet::Files.new(request.body)
      end
      alias :search :files_search

      def trashbox_files_get(offset: 1, limit: 100)
        request = connection("cabinet/trashbox/files/get").get do |req|
          req.params[:offset] = offset
          req.params[:limit] = limit
        end
        ::RWS::Response::Cabinet::Files.new(request.body)
      end
      alias :trashbox_files :trashbox_files_get

      def trashbox_file_revert(file_id:, folder_id:)
        xml = convert_xml(fileRevertRequest: { file: { fileId: file_id, folderId: folder_id } })
        request = connection("cabinet/trashbox/file/revert").post { |req| req.body = xml }
        ::RWS::Response::Cabinet::Result.new(request.body)
      end
      alias :restore :trashbox_file_revert

      def file_update(file_id:, file_name: nil, file_path: nil, file: nil)
        params = { fileId: file_id, fileName: file_name, filePath: file_path }
        xml = convert_xml(fileUpdateRequest: { file: params.compact })
        payload = { xml: xml, file: file }
        request = multipart_connection("cabinet/file/update").post("", payload)
        ::RWS::Response::Cabinet::Result.new(request.body)
      end
      alias :update :file_update

      def folder_insert(folder_name:, directory_name: nil, upper_folder_id: nil)
        params = { folderName: folder_name, directoryName: directory_name, upper_folder_id: upper_folder_id }
        xml = convert_xml(folderInsertRequest: { folder: params.compact } )
        request = connection("cabinet/folder/insert").post { |req| req.body = xml }
        ::RWS::Response::Cabinet::Result.new(request.body)
      end
      alias :create_folder :folder_insert
    end
  end
end
