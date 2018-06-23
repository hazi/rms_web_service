# frozen_string_literal: true

module RmsWebService
  module Client
    class Category < Base
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
