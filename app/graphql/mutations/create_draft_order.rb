module Mutations
  class CreateDraftOrder < BaseMutation
    argument :line_items, [Types::LineItemAttributes], required: true

    field :draft_order, Types::DraftOrderType, null: false

    def resolve(line_items:)
      raise Errors::Unauthorized if context[:current_user].nil?

      draft_order = DraftOrder.new(user: context[:current_user])
      create_line_items(draft_order, line_items)

      draft_order.save!
      {
        draft_order: draft_order
      }
    end

    private

    def create_line_items(draft_order, line_items)
      line_items.each do |line_item|
        _, item_id = GraphQL::Schema::UniqueWithinType.decode(line_item.product_id)
        product = Product.find(item_id)
        LineItem.create!(quantity: line_item.quantity, product: product, draft_order: draft_order)
      end
    end
  end
end