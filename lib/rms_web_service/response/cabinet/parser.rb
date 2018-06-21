# frozen_string_literal: true

require "nokogiri"

module RmsWebService
  module Response
    module Cabinet
      class Parser
        attr_accessor :status, :raw_xml
        def initialize(xml)
          @raw_xml = xml.is_a?(::File) ? xml.read : xml
          @parsed_xml = Nokogiri::XML.parse(@raw_xml)
          @status = Cabinet::Status.new(@raw_xml)
          @errors = []
        end

        def set_attributes(args)
          args.each { |s| set_attribute(s.name, s.content) }
        end

        def set_attribute(name, content)
          define_singleton_method(name.underscore) { content }
        end
      end
    end
  end
end
