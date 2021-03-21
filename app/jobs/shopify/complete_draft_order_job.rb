module Shopify
  class CompleteDraftOrderJob < ApplicationJob
    queue_as :ecfs_shopify_complete_draft_order

    def perform(draft_order_id)
      draft_order = DraftOrder.find(draft_order_id)

      order_service = OrderService.new
      shopify_order_id = order_service.complete_draft_order(draft_order.shopify_id)["order"]["id"]
      shopify_order = order_service.order(shopify_order_id)
      Order.from_shopify(shopify_order, draft_order)
    end
  end
end