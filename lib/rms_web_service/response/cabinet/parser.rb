require 'nokogiri'

module RmsWebService
  module Response
    module Cabinet 
      class Parser < Array
        attr_accessor :status
        def initialize(xml)
          xml = xml.read if xml.is_a?(::File)
          @parsed_xml = Nokogiri::XML.parse(xml)
          @status = Cabinet::Status.new(xml)
          @result_code = @parsed_xml.xpath("//resultCode").first.content if @parsed_xml.xpath("//resultCode").present?
          @errors = []
        end

        def set_attributes(args)
          args.each {|s| set_attribute(s.name, s.content)}
        end

        def set_attribute(name, content)
          define_singleton_method(name.underscore) {content}
        end
      end
    end
  end
end
