# frozen_string_literal: true

module RmsWebService
  module Response
    module Cabinet
      class Files < Parser
        def initialize(xml)
          super

          if @result.key?(:cabinet_folder_files_get_result)
            set_attributes @result.dig(:cabinet_folder_files_get_result)
            set_attribute("files",
              Array.wrap(@result.dig(:cabinet_folder_files_get_result, :files, :file)))
          elsif @result.key?(:cabinet_files_search_result)
            set_attributes @result.dig(:cabinet_files_search_result)
            set_attribute("files",
              Array.wrap(@result.dig(:cabinet_files_search_result, :files, :file)))
          elsif @result.key?(:cabinet_trashbox_files_get_result)
            set_attributes @result.dig(:cabinet_trashbox_files_get_result)
            set_attribute("files",
              Array.wrap(@result.dig(:cabinet_trashbox_files_get_result, :files, :file)))
          end
        end

        def success?
          @result_code == "0"
        end
      end
    end
  end
end
