# frozen_string_literal: true

module RmsWebService
  module Client
    class ShopManagement < Base
      def dsgn_navitemplate_list_get(opt={})
        request = connection("shopmngt/design/navitemplate/list/get").get do |req|
          req.params["layoutCommonId"] = opt[:layout_common_id] if opt.key?(:layout_common_id)
        end
        ::RWS::Response::ShopManagement::Design::NaviTemplate::List::Get.new(request.body)
      end

      def dsgn_featured_item_list_get(opt={})
        request = connection("shopmngt/design/featured/item/list/get").get do |req|
          req.params["lossLeaderId"] = opt[:loss_leader_id] if opt.key?(:loss_leader_id)
        end
        ::RWS::Response::ShopManagement::Design::Featured::Item::List::Get.new(request.body)
      end

      def dsgn_description_s_list_get(opt={})
        request = connection("shopmngt/design/description/small/list/get").get do |req|
          req.params["textSmallId"] = opt[:text_small_id] if opt.key?(:text_small_id)
        end
        ::RWS::Response::ShopManagement::Design::Description::Small::List::Get.new(request.body)
      end

      def dsgn_description_l_list_get(opt={})
        request = connection("shopmngt/design/description/large/list/get").get do |req|
          req.params["textLargeId"] = opt[:text_large_id] if opt.key?(:text_large_id)
        end
        ::RWS::Response::ShopManagement::Design::Description::Large::List::Get.new(request.body)
      end
    end
  end
end
