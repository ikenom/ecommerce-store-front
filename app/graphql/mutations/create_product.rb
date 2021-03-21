module Mutations
  class CreateProduct < BaseMutation
    argument :name, String, required: true
    argument :price, Float, required: true
    argument :type, String, required: true
    argument :cms_id, ID, required: true

    field :product, Types::ProductType, null: false

    def resolve(**attributes)
      raise Errors::Unauthorized if context[:current_user].nil?

      user = context[:current_user]
      product = Product.create!(user: user, **attributes)
      {
        product: product
      }
    end
  end
end
