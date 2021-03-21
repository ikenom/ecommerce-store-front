module Mutations
  class Checkout < BaseMutation
    argument :draft_order_id, ID, required: true, loads: Types::DraftOrderType

    field :order, Types::OrderType, null: false

    def resolve(draft_order:)
      order = Shopify::CompleteDraftOrderJob.perform_now(draft_order.id.to_s)
      {
        order: order
      }
    end
  end
end