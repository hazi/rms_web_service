# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      module File
        class Delete < Parser
          def initialize(xml)
            super
            set_attributes @parsed_xml.xpath("//cabinetFileDeleteResult").children
          end

          def success?
            @result_code == "0"
          end
        end
      end
    end
  end
end
