module Types
  class OrderType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :canceled_at, GraphQL::Types::ISO8601DateTime, null: true
    field :closed_at, GraphQL::Types::ISO8601DateTime, null: true
    field :instructions, String, null: false
    field :fullfilment_status, Types::FullfilmentStatus, null: false
    field :line_items, LineItemType.connection_type, null: false
    field :user, UserType, null: false
    field :total_price, MoneyType, null: false
  end
end
