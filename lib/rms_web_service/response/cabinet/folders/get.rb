# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      module Folders
        class Get < Parser
          def initialize(xml)
            super
            set_attributes @result.dig(:cabinet_folders_get_result)

            set_attribute(
              "folders",
              Array.wrap(@result.dig(:cabinet_folders_get_result, :folders, :folder))
            )
          end

          def success?
            @result_code == "0"
          end
        end
      end
    end
  end
end
