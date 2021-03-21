module Types
  class ProductType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id
    field :name, String, null: false
    field :addon, AddonType.connection_type, null: false
    field :priced_addons, ProductType.connection_type, null: false
  end
end
