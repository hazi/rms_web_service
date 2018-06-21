module RmsWebService
  module Client
    class Inventory < Base
      Endpoint = "https://api.rms.rakuten.co.jp/es/1.0/"

      def get_inventory_external(args)
        xml = convert_xml(getInventoryExternal: args)
        request = connection("inventory/get_inventory_external").post { |req| req.body = xml }
        ::RWS::Response::Inventory::GetInventoryExternal.new(request.body)
      end

      def update_inventory_external(args)
        xml = convert_xml(updateInventoryExternal: args)
        request = connection("inventory/update_inventory_external").post { |req| req.body = xml }
        ::RWS::Response::Inventory::UpdateInventoryExternal.new(request.body)
      end
    end
  end
end
