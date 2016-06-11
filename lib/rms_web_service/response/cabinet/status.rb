module RmsWebService
  module Response
    module Cabinet 
      class Status < Parser
        def initialize(xml)
          puts "cabinet status. xml=#{xml}"
          set_attributes Nokogiri::XML.parse(xml).xpath("//status").children
        end
      end
    end
  end
end
