class Types::FulfillmentRequestStatus < Types::BaseEnum
  value "SUBMITTED", "The fulfillment order has been submitted."
  value "ACCEPTED", "The fulfillment order has been accepted."
  value "CLOSED", "The fulfillment order has been completd."
end