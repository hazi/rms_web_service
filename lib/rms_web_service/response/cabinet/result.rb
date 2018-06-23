# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      class Result < Parser
        def initialize(xml)
          super

          if @result.key?(:cabinet_folder_insert_result)
            set_attributes @result.dig(:cabinet_folder_insert_result)
          elsif @result.key?(:cabinet_file_update_result)
            set_attributes @result.dig(:cabinet_file_update_result)
          elsif @result.key?(:cabinet_trashbox_file_revert_result)
            set_attributes @result.dig(:cabinet_trashbox_file_revert_result)
          elsif @result.key?(:cabinet_file_insert_result)
            set_attributes @result.dig(:cabinet_file_insert_result)
          elsif @result.key?(:cabinet_file_delete_result)
            set_attributes @result.dig(:cabinet_file_delete_result)
          end
        end

        # @!method status
        # ステータス情報を返します
        # @return [Cabinet::Status]

        # @!method result_code
        # 結果コード
        # @return [String]

        # @!method folder_id
        # フォルダを作成した際には folderId が入る
        # @return [String]

        # @!method file_id
        # ファイルをアップロードした際には fileId が入る
        # @return [String]
      end
    end
  end
end
