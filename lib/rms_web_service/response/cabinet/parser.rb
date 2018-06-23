# frozen_string_literal: true

require "nori"

module RmsWebService
  module Response
    module Cabinet

      # Cabinet Response Parser SuperClass
      class Parser
        # @return [Cabinet::Status]
        attr_accessor :status

        # @return [String]
        attr_accessor :raw_xml

        def initialize(xml)
          @raw_xml = xml.is_a?(::File) ? xml.read : xml
          @result  = parse(raw_xml)[:result]
          @status  = Cabinet::Status.new(@result)
        end

        # 引数の Hash を元にメソッドを定義
        # @param args [Hash]
        def set_attributes(args)
          args.each { |key, value| set_attribute(key, value) }
        end

        # 引数の値を返却するメソッドを定義
        #
        # @param name [String, Symbol]
        # @param content [Any]
        def set_attribute(name, content)
          define_singleton_method(name) { content }
        end

        # 引数のXML を Hash 化
        #
        # @param xml [String]
        # @return [Hash]
        def parse(xml)
          @parser ||= Nori.new(convert_tags_to: lambda { |tag| tag.snakecase.to_sym })
          @parser.parse(xml)
        end

        # 結果コード が 0 の時 `true` を返します
        def success?
          result_code == "0"
        end
      end
    end
  end
end
