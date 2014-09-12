module RmsWebService
  module Response
    module Item
      class Search < Parser
        attr_accessor :code
        def initialize(xml)
          xml = Nokogiri::XML.parse(xml)
          xml.xpath("//items").children.each {|item| self << Get.new(item.to_xml)}
          @code = xml.xpath("//code").first.content
          super
        end
      end
    end
  end
end
