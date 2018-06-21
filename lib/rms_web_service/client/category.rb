module RmsWebService
  module Client
    class Category < Base
      Endpoint = "https://api.rms.rakuten.co.jp/es/1.0/"

      def shop_categories_get(opt={})
        request = connection("categoryapi/shop/categories/get").get do |req|
          if opt.key(:category_set_manage_number)
            req.params["categorySetManageNumber"] = opt[:category_set_manage_number]
          end
        end
        ::RWS::Response::Category::Shop::Categories::Get.new(request.body)
      end
    end
  end
end
