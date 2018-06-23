# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      class Usage < Parser
        def initialize(xml)
          super
          set_attributes @result.dig(:cabinet_usage_get_result)
        end

        # @!method status
        # ステータス情報を返します
        # @return [Cabinet::Status]

        # @!method max_space
        # 契約容量 (MB)
        # @return [String]

        # @!method folder_max
        # フォルダ数上限
        # @return [String]

        # @!method file_max
        # フォルダ内画像数上限
        # @return [String]

        # @!method use_space
        # 利用容量 (KB)
        # @return [String]

        # @!method avail_space
        # 利用可能容量 (KB)
        # @return [String]

        # @!method use_folder_count
        # 利用フォルダ数
        # @return [String]

        # @!method avail_folder_count
        # 利用可能フォルダ数
        # @return [String]
      end
    end
  end
end
