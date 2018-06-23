# frozen_string_literal: true

require "nori"

module RmsWebService
  module Response
    module Cabinet
      class Parser
        attr_accessor :status, :raw_xml
        def initialize(xml)
          @raw_xml = xml.is_a?(::File) ? xml.read : xml
          @result  = parser(raw_xml)[:result]
          @status  = Cabinet::Status.new(@result)
        end

        def set_attributes(args)
          args.each { |key, value| set_attribute(key, value) }
        end

        def set_attribute(name, content)
          define_singleton_method(name) { content }
        end

        def parser(xml)
          @parser ||= Nori.new(convert_tags_to: lambda { |tag| tag.snakecase.to_sym })
          @parser.parse(xml)
        end

        def success?
          result_code == "0"
        end
      end
    end
  end
end
