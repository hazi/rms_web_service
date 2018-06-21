module RmsWebService
  module Response
    module Cabinet
      module File
        class Insert < Parser
          def initialize(xml)
            super
            set_attributes @parsed_xml.xpath("//cabinetFileInsertResult").children
          end

          def success?
            @result_code == "0"
          end
        end
      end
    end
  end
end
