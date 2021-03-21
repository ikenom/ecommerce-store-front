module Types
  class LineItemType < Types::BaseObject
    field :product, ProductType, null: false
    field :quantity, Integer, null: false
    field :addons, AddonType.connection_type, null: false
    field :priced_addons, LineItemType.connection_type, null: false
  end
end
