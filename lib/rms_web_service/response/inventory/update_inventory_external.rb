# frozen_string_literal: true

module RmsWebService
  module Response
    module Inventory
      class UpdateInventoryExternal < Parser
        def initialize(xml)
          super
          set_attributes @parsed_xml.xpath("//updateInventoryExternalResponse").children
        end

        def success?
          @result_code == "0"
        end
      end
    end
  end
end
