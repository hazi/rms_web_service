require "nokogiri"

module RmsWebService
  module Response
    module Item
      class Parser < Array
        attr_accessor :status, :raw_xml
        def initialize(xml)
          @raw_xml = xml.is_a?(::File) ? xml.read : xml
          @parsed_xml = Nokogiri::XML.parse(@raw_xml)
          @status = Item::Status.new(@raw_xml)
          @code = @parsed_xml.xpath("//code").first.content if @parsed_xml.xpath("//code").present?
          @errors = []
          @parsed_xml.xpath("//errorMessages").children.each { |error| @errors << Error.parse(error.to_s) } if @parsed_xml.xpath("//errorMessages").present?
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
