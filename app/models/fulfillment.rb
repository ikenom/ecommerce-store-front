class Fulfillment
  include Mongoid::Document

  field :type, type: String
  field :request_status, type: String, default: "SUBMITTED"
  field :status, type: String, default: "OPEN"

  belongs_to :order
end