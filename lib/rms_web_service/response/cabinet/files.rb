# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      class Files < Parser
        def initialize(xml)
          super

          if @result.key?(:cabinet_folder_files_get_result)
            set_attributes @result.dig(:cabinet_folder_files_get_result)
            set_attribute("files",
              Array.wrap(@result.dig(:cabinet_folder_files_get_result, :files, :file)))
          elsif @result.key?(:cabinet_files_search_result)
            set_attributes @result.dig(:cabinet_files_search_result)
            set_attribute("files",
              Array.wrap(@result.dig(:cabinet_files_search_result, :files, :file)))
          elsif @result.key?(:cabinet_trashbox_files_get_result)
            set_attributes @result.dig(:cabinet_trashbox_files_get_result)
            set_attribute("files",
              Array.wrap(@result.dig(:cabinet_trashbox_files_get_result, :files, :file)))
          end
        end

        # @!method status
        # ステータス情報を返します
        # @return [Cabinet::Status]

        # @!method result_code
        # 結果コード
        # @return [String]

        # @!method file_all_count
        # 全ファイル数
        # @return [String]

        # @!method file_count
        # 返却ファイル数
        # @return [String]

        # @!method files
        # ファイル情報一覧
        # @return [Array<Hash>]
      end
    end
  end
end
