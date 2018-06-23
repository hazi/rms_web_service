# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      module Usage
        class Get < Parser
          def initialize(xml)
            super
            set_attributes @result.dig(:cabinet_usage_get_result)
          end
        end
      end
    end
  end
end
