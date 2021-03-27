module Types
  class FulfillmentType < Types::BaseObject
    field :type, FulfillmentTypeType, null: false
    field :status, FulfillmentStatus, null: false
    field :request_status, FulfillmentRequestStatus, null: false
  end
end
