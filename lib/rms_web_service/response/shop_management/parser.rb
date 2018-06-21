require "nokogiri"

module RmsWebService
  module Response
    module ShopManagement
      class Parser < Array
        attr_accessor :system_status, :raw_xml
        def initialize(xml)
          @raw_xml = xml.is_a?(::File) ? xml.read : xml
          @parsed_xml = Nokogiri::XML.parse(@raw_xml)
          @system_status = Cabinet::Status.new(@raw_xml)
          @result_code = @parsed_xml.xpath("//resultCode").first.content if @parsed_xml.xpath("//resultCode").present?
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
