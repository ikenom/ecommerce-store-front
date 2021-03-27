module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :orders, Types::OrderType.connection_type, null: false do
      argument :fulfillment_type, Types::FulfillmentTypeType, required: false
      argument :fulfillment_request_status, Types::FulfillmentRequestStatus, required: false
    end

    def orders(**attributes)
      raise Errors::Unauthorized if context[:current_user].nil?

      orders = Order.where(user: context[:current_user])
      orders = if attributes[:fulfillment_type].present?
        fulfillments = Fulfillment.where(type: attributes[:fulfillment_type], request_status: attributes[:fulfillment_request_status])
        fulfillments.map(&:order)
      end

      orders = orders.reject { |order| order.user.id != context[:current_user].id}
      orders
    end
  end
end
