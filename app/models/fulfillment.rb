class Fulfillment
  include Mongoid::Document

  field :type, type: String
  field :request_status, type: String, default: "SUBMITTED"
  field :status, type: String, default: "OPEN"

  belongs_to :order

  after_update :publish_update

  private

  def publish_update
    PublishJob.perform_later("core.fulfillment.updated", {
      id: self.to_global_id.to_s,
      order_id: order.to_global_id.to_s
    })
  end
end