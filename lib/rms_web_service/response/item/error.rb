#encoding: utf-8
# frozen_string_literal: true

module RmsWebService
  module Response
    module Item
      class Error
        extend RmsWebService::Response::Item::ErrorConst
        def self.parse(xml)
          unless xml.class == String
            raise ArgumentError, "Argument must be a String class. but argument is #{xml.class}."
          end

          hash = Hash.new
          Nokogiri::XML.parse(xml).xpath("//errorMessage").children.each do |att|
            hash.store(att.name.underscore, att.content)
          end

          if hash["field_id"] && singleton_class::FIELDID_LIST["#{hash['field_id']}"].present?
            hash.store("field", singleton_class::FIELDID_LIST["#{hash['field_id']}"][0].underscore)
            hash.store("field_name", singleton_class::FIELDID_LIST["#{hash['field_id']}"][1].underscore)
          end
          hash
        end
      end
    end
  end
end
