module Types
  class DraftOrderType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id

    field :line_items, LineItemType.connection_type, null: false
    field :user, UserType, null: false
  end
end
