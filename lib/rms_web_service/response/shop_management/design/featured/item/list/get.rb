module RmsWebService
  module Response
    module ShopManagement
      module Design
        module Featured 
          module Item 
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
