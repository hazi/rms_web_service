module RmsWebService
  module Response
    module Item
      class Parser < Array
        attr_accessor :status
        def initialize(xml)
          @status = Item::Status.new(xml)
        end

        def set_attributes(args)
          args.each {|s| set_attribute(s.name, s.content)}
        end

        def set_attribute(name, content)
          att = name.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase
          self.define_singleton_method(att) {content}
        end
      end
    end
  end
end
