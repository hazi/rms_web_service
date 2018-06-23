# frozen_string_literal: true

module RmsWebService
  module Client
    # R-Cabinet上のフォルダ、画像の管理をサポートします
    class Cabinet < Base
      # 画像ファイルをアップロード
      #
      # @param file [UploadIO] 画像データ
      # @param folder_id [Integer]
      # @param file_name [String] 画像名
      # @param file_path [String] file名 (URLの最後にあたる部分)
      # @param over_write [true, false] true の場合、同じ folder_id に同じ file_path のファイルがある場合上書きします
      # @return [RmsWebService::Response::Cabinet::Result]
      def upload(file:, folder_id:, file_name:, file_path: nil, over_write: false)
        params = { fileName: file_name, folderId: folder_id, filePath: file_path, overWrite: over_write }
        xml = convert_xml(fileInsertRequest: { file: params.compact })
        payload = { xml: xml, file: file }
        request = multipart_connection("cabinet/file/insert").post("", payload)
        Response::Cabinet::Result.new(request.body)
      end
      alias :file_insert :upload

      # 指定した画像を削除フォルダに移動
      #
      # @param file_id [Integer]
      # @return [RmsWebService::Response::Cabinet::Result]
      def delete(file_id)
        xml = convert_xml(fileDeleteRequest: { file: { fileId: file_id } })
        request = connection("cabinet/file/delete").post { |req| req.body = xml }
        Response::Cabinet::Result.new(request.body)
      end
      alias :file_delete :delete

      # R-Cabinetの利用状況を取得
      #
      # @return [RmsWebService::Response::Cabinet::Usage]
      def usage
        request = connection("cabinet/usage/get").get
        Response::Cabinet::Usage.new(request.body)
      end
      alias :usage_get :usage

      # フォルダの一覧を取得
      #
      # @param offset [Integer] 1を基準値としたページ数
      # @param limit [Integer] 1ページあたりの取得上限数 (MAX: 100)
      # @return [RmsWebService::Response::Cabinet::Folders]
      def folders(offset: 1, limit: 100)
        request = connection("cabinet/folders/get").get do |req|
          req.params[:offset] = offset
          req.params[:limit] = limit
        end
        Response::Cabinet::Folders.new(request.body)
      end
      alias :folders_get :folders

      # 指定したフォルダ内の画像一覧を取得
      #
      # @param folder_id [Type]
      # @param offset [integer] 1を基準値としたページ数
      # @param limit [integer] 1ページあたりの取得上限数 (MAX: 100)
      # @return [RmsWebService::Response::Cabinet::Files]
      def folder_files(folder_id:, offset: 1, limit: 100)
        request = connection("cabinet/folder/files/get").get do |req|
          req.params[:folderId] = folder_id
          req.params[:offset] = offset
          req.params[:limit] = limit
        end
        Response::Cabinet::Files.new(request.body)
      end
      alias :folder_files_get :folder_files

      # file_id, file_path, file_name いずれかを元に画像を検索
      #
      # @param args [Hash]
      # @option args [Integer] :file_id 画像ID
      # @option args [String] :file_path ファイル名
      # @option args [String] :file_name 画像名
      # @option args [Integer] :folder_id フォルダID
      # @option args [String] :folder_path フォルダ名
      # @option args [integer] :offset 1を基準値としたページ数
      # @option args [integer] :limit 1ページあたりの取得上限数 (MAX: 100)
      # @return [RmsWebService::Response::Cabinet::Files]
      # @note file_id, file_path, file_name のうちいずれか一つを必ず指定する必要あります。
      # @note folder_id, folder_path を両方指定した場合は、フォルダIDを優先して検索します。
      def search(args)
        request = connection("cabinet/files/search").get do |req|
          params = args.deep_transform_keys { |key| key.to_s.camelcase.sub(/^./, &:downcase) }
          req.params.update(params)
        end
        Response::Cabinet::Files.new(request.body)
      end
      alias :files_search :search

      # 削除フォルダ内にある削除した画像の一覧を取得
      #
      # @param offset [integer] 1を基準値としたページ数
      # @param limit [integer] 1ページあたりの取得上限数 (MAX: 100)
      # @return [RmsWebService::Response::Cabinet::Files]
      def trashbox_files(offset: 1, limit: 100)
        request = connection("cabinet/trashbox/files/get").get do |req|
          req.params[:offset] = offset
          req.params[:limit] = limit
        end
        Response::Cabinet::Files.new(request.body)
      end
      alias :trashbox_files_get :trashbox_files

      # 削除フォルダ内にある画像を指定したフォルダに戻す
      #
      # @param file_id [Type]
      # @param folder_id [Type]
      # @return [RmsWebService::Response::Cabinet::Result]
      def restore(file_id:, folder_id:)
        xml = convert_xml(fileRevertRequest: { file: { fileId: file_id, folderId: folder_id } })
        request = connection("cabinet/trashbox/file/revert").post { |req| req.body = xml }
        Response::Cabinet::Result.new(request.body)
      end
      alias :trashbox_file_revert :restore

      # 画像の file_name, file_path, file(画像) を上書きします
      #
      # @param file_id [Integer]
      # @param file_name [String] 画像名
      # @param file_path [String] file名 (URLの最後にあたる部分)
      # @param file [UploadIO] 画像データ
      # @return [RmsWebService::Response::Cabinet::Result]
      # @example
      #   file = UploadIO.new("/file/path/to/image.jpg", "image/jpeg")
      #   RmsWebService::Client::Cabinet.new.file_update(file_id: 11111111, file: file)
      # @note file_path を使ってフォルダの移動はできません。
      def update(file_id:, file_name: nil, file_path: nil, file: nil)
        params = { fileId: file_id, fileName: file_name, filePath: file_path }
        xml = convert_xml(fileUpdateRequest: { file: params.compact })
        payload = { xml: xml, file: file }
        request = multipart_connection("cabinet/file/update").post("", payload)
        Response::Cabinet::Result.new(request.body)
      end
      alias :file_update :update

      # フォルダを作成
      #
      # @param folder_name [Type]
      # @param directory_name [Type]
      # @param upper_folder_id [Type]
      # @return [RmsWebService::Response::Cabinet::Result]
      def create_folder(folder_name:, directory_name: nil, upper_folder_id: nil)
        params = { folderName: folder_name, directoryName: directory_name, upper_folder_id: upper_folder_id }
        xml = convert_xml(folderInsertRequest: { folder: params.compact } )
        request = connection("cabinet/folder/insert").post { |req| req.body = xml }
        Response::Cabinet::Result.new(request.body)
      end
      alias :folder_insert :create_folder
    end
  end
end
