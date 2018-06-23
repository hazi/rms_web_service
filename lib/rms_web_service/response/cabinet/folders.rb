# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      class Folders < Parser
        def initialize(xml)
          super
          set_attributes @result.dig(:cabinet_folders_get_result)

          set_attribute(
            "folders",
            Array.wrap(@result.dig(:cabinet_folders_get_result, :folders, :folder))
          )
        end

        # @!method status
        # ステータス情報を返します
        # @return [Cabinet::Status]

        # @!method result_code
        # 結果コード
        # @return [String]

        # @!method folder_all_count
        # 全フォルダ数
        # @return [String]

        # @!method folder_count
        # 返却フォルダ数
        # @return [String]

        # @!method folders
        # フォルダ情報一覧
        # @return [Array<Hash>]
      end
    end
  end
end
