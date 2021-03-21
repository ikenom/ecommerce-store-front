module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :orders, Types::OrderType.connection_type, null: false do
      argument :fullfilment_status, Types::FullfilmentStatus, required: false
    end

    def orders(**attributes)
      raise Errors::Unauthorized if context[:current_user].nil?

      order = Order.where(user: context[:current_user])
      order.where(fullfilment_status: attributes[:fullfilment_status]) unless attributes[:fullfilment_status].nil?
      order
    end
  end
end
