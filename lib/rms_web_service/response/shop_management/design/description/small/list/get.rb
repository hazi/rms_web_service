module RmsWebService
  module Response
    module ShopManagement
      module Design 
        module Description 
          module Small 
            module List 
              class Get < Parser
                attr_accessor :code
                def initialize(xml)
                  super
                  set_attributes @parsed_xml.xpath("//result").last.children
                end

                def success?
                  @result_code == "N000" ? true : false
                end
              end
            end
          end
        end
      end
    end
  end
end
