class Types::FulfillmentRequestStatus < Types::BaseEnum
  value "SUBMITTED", "The fulfillment order has been submitted."
  value "ACCEPTED", "The fulfillment order has been accepted."
  value "CLOSED", "The fulfillment order has been completd."
  value "PAUSED", "The fulfillment order has been paused."
  value "CANCELLATION_REQUESTED", "Cancellation has been requested."
end