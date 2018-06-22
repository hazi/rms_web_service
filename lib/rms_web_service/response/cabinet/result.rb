# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      class Result < Parser
        def initialize(xml)
          super

          if @result.key?(:cabinet_folder_insert_result)
            set_attributes @result.dig(:cabinet_folder_insert_result)
          elsif @result.key?(:cabinet_file_update_result)
            set_attributes @result.dig(:cabinet_file_update_result)
          elsif @result.key?(:cabinet_trashbox_file_revert_result)
            set_attributes @result.dig(:cabinet_trashbox_file_revert_result)
          end
        end

        def success?
          @result_code == "0"
        end
      end
    end
  end
end
