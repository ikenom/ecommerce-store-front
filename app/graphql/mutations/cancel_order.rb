module Mutations
  class CancelOrder < BaseMutation
    argument :fulfillment_id, ID, required: true, loads: Types::FulfillmentType

    field :fulfillment, Types::FulfillmentType, null: false

    def resolve(fulfillment:)
      fulfillment.update!(request_status: "CANCELLATION_REQUESTED")

      {
        fulfillment: fulfillment
      }
    end
  end
end