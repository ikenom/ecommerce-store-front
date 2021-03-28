module Types
  class FulfillmentType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id
    field :type, FulfillmentTypeType, null: false
    field :status, FulfillmentStatus, null: false
    field :request_status, FulfillmentRequestStatus, null: false
  end
end
