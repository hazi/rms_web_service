module RmsWebService
  module Response
    module Navigation
      module Genre
        class Get < Parser
          attr_accessor :code
          def initialize(xml)
            super
            set_attributes @parsed_xml.xpath("//navigationGenreGetResult").children
          end

          def success?
            @status == "Success" ? true : false
          end
        end
      end
    end
  end
end
