module Shopify
  class CreateDraftOrderJob < ApplicationJob
    queue_as :ecfs_shopify_create_draft_order

    def perform(draft_order_id)
      draft_order = DraftOrder.find(draft_order_id)

      order_service = OrderService.new
      line_item_attributes = draft_order.line_items.map do |line_item|
        variant_id = line_item.product.shopify_variant_id
        {
          variantId: variant_id,
          quantity: line_item.quantity
        }
      end
      shopify_draft_order = order_service.create_draft_order(draft_order.user.ec_id, line_item_attributes)
      draft_order.update!(shopify_id: shopify_draft_order["id"])
    end
  end
end