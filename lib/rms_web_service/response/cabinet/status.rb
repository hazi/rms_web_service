# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      class Status < Parser
        def initialize(hash)
          set_attributes(hash.dig(:status))
        end

        # systemStatus が OK の場合 true を返します
        def success?
          system_status == "OK"
        end

        # @!method interface_id
        # API識別子
        # @return [String]

        # @!method system_status
        # APIリクエストに対する結果ステータス
        # @return [String]

        # @!method message
        # APIリクエストに対する結果メッセージ
        # @return [String]

        # @!method request_id
        # APIリクエスト識別子
        # @return [String]

        # @!method requests
        # APIリクエスト情報
        # @note API Function によって返却されない場合があります。その場合このメソッドは存在しません。
        # @return [Hash]
      end
    end
  end
end
