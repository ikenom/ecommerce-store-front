module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :orders, Types::OrderType.connection_type, null: false do
      argument :fullfilment_status, Types::FullfilmentStatus, required: false
    end

    def orders(**attributes)
      return Order.all if attributes[:fullfilment_status].nil?
      Order.where(fullfilment_status: attributes[:fullfilment_status])
    end
  end
end
