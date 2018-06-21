module RmsWebService
  module Client
    class Item < Base
      Endpoint = "https://api.rms.rakuten.co.jp/es/1.0/"

      def get(item_url)
        request = connection("item/get").get { |req| req.params["itemUrl"] = item_url }
        ::RWS::Response::Item::Get.new(request.body)
      end

      def insert(args)
        xml = case args
              when String
                args
              when Hash then
                convert_xml(itemInsertRequest: { item: args })
              end

        request = connection("item/insert").post { |req| req.body = xml }
        ::RWS::Response::Item::Insert.new(request.body)
      end

      def update(args)
        xml = case args
              when String
                args
              when Hash then
                convert_xml(itemUpdateRequest: { item: args })
              end

        request = connection("item/update").post { |req| req.body = xml }
        ::RWS::Response::Item::Update.new(request.body)
      end

      def delete(item_url)
        xml = convert_xml(itemDeleteRequest: { item: { itemUrl: item_url } })
        request = connection("item/delete").post { |req| req.body = xml }
        ::RWS::Response::Item::Delete.new(request.body)
      end

      def search(args)
        request = connection("item/search").get do |req|
          args.each { |key, value| req.params["#{key.to_s.camelize(:lower)}"] = args[:"#{key}"] }
        end
        ::RWS::Response::Item::Search.new(request.body)
      end

      def items_update(args)
        xml = convert_xml(itemsUpdateRequest: { items: args })
        request = connection("items/update").post { |req| req.body = xml }
        ::RWS::Response::Item::ItemsUpdate.new(request.body)
      end
    end
  end
end
