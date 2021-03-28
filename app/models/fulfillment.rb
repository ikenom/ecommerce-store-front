class Fulfillment
  include Mongoid::Document

  field :type, type: String
  field :request_status, type: String, default: "SUBMITTED"
  field :status, type: String, default: "OPEN"

  belongs_to :order

  after_create :publish_create
  after_update :publish_update

  private

  def publish_create
    kitchen_fulfillment = fulfillments.find_by(type: "KITCHEN")
    PublishJob.perform_later("core.fulfillment.created", {
      id: self.to_global_id.to_s,
      user_id: user.to_global_id.to_s,
      kitchen_fulfillment_id: kitchen_fulfillment.to_global_id.to_s
    })
  end

  def publish_update
    PublishJob.perform_later("core.fulfillment.updated", {
      id: self.to_global_id.to_s
    })
  end
end