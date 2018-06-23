# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      module File
        class Delete < Parser
          def initialize(xml)
            super
            set_attributes @result.dig(:cabinet_file_delete_result)
          end
        end
      end
    end
  end
end
