class DraftOrder
  include Mongoid::Document
  include ShopifyModel

  has_many :line_items
  belongs_to :user

  after_create :create_for_shopify

  private

  def create_for_shopify
    Shopify::CreateDraftOrderJob.perform_now(self.id.to_s)
  end
end