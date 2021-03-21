class Order
  # .delegate is broken in mongoid 7.1.0. To get around error, the delgate definition has to be
  # placed before including Mongoid::Document. See https://jira.mongodb.org/browse/MONGOID-4849
  delegate :line_items, to: :draft_order

  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  include ShopifyModel

  field :canceled_at, type: DateTime
  field :closed_at, type: DateTime
  field :instructions, type: String
  field :fullfilment_status, type: String

  belongs_to :draft_order
  belongs_to :user
  embeds_one :total_price, class_name: Money

  after_create :publish_create

  class << self
    def from_shopify(shopify_order, draft_order)
      attributes = Order.attributes_from_shopify(shopify_order)
      attributes.merge!({
        draft_order: draft_order,
        user: draft_order.user
      })

      Order.create!(**attributes)
    end

    def attributes_from_shopify(shopify_order)
      {
        shopify_id: shopify_order["id"],
        canceled_at: shopify_order["cancelledAt"],
        closed_at: shopify_order["closedAt"],
        fullfilment_status: shopify_order["fulfillmentOrders"]["edges"].first["node"]["status"],
        total_price: {
          amount: shopify_order["totalPriceSet"]["presentmentMoney"]["amount"],
          currency: shopify_order["totalPriceSet"]["presentmentMoney"]["currencyCode"]
        }
      }
    end
  end

  def update_from_shopify(shopify_order)
    attributes = Order.attributes_from_shopify(shopify_order)
    Order.update!(**attributes)
  end

  def publish_create
    PublishJob.perform_later("core.order.created", {
      order_id: self.id.to_s
    })
  end
end