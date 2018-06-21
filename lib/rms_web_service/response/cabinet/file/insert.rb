# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      module File
        class Insert < Parser
          def initialize(xml)
            super
            set_attributes @result.dig(:cabinet_file_insert_result)
          end

          def success?
            @result_code == "0"
          end
        end
      end
    end
  end
end
