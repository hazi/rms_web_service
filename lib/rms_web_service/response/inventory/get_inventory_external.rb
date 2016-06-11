module RmsWebService
  module Response
    module Inventory 
      class GetInventoryExternal < Parser
        def initialize(xml)
          super
          set_attributes @parsed_xml.xpath("//getInventoryExternalResponse").children
        end

        def success?
          @result_code == "0"
        end
      end
    end
  end
end
