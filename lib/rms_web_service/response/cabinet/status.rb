# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      class Status < Parser
        def initialize(hash)
          set_attributes(hash.dig(:status))
        end

        def success?
          system_status == "OK"
        end
      end
    end
  end
end
