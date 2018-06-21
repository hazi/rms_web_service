# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      module Usage
        class Get < Parser
          def initialize(xml)
            super
            set_attributes @parsed_xml.xpath("//cabinetUsageGetResult").children
          end

          def success?
            @result_code == "0"
          end
        end
      end
    end
  end
end
