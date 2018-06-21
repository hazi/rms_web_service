# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      class Status < Parser
        def initialize(xml)
          set_attributes Nokogiri::XML.parse(xml).xpath("//status").children
        end
      end
    end
  end
end
