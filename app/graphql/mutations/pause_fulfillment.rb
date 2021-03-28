module Mutations
  class PauseFulfillment < BaseMutation
    argument :fulfillment_id, ID, required: true, loads: Types::FulfillmentType

    field :fulfillment, Types::FulfillmentType, null: false

    def resolve(fulfillment:)
      fulfillment.update!(request_status: "PAUSE")

      {
        fulfillment: fulfillment
      }
    end
  end
end