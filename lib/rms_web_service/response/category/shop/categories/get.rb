# frozen_string_literal: true

module RmsWebService
  module Response
    module Category
      module Shop
        module Categories
          class Get < Parser
            attr_accessor :code
            def initialize(xml)
              super
              set_attributes @parsed_xml.xpath("//categoriesGetResult").children
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
