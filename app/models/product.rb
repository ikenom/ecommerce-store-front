class Product
  include Mongoid::Document
  include ShopifyModel

  field :name, type: String
  field :price, type: Float
  field :type, type: String
  field :cms_id, type: String
  field :shopify_variant_id, type: String

  has_many :addons
  has_many :priced_addons, class_name: "Product"
  belongs_to :user

  after_create :create_for_shopify

  def create_for_shopify
    Shopify::CreateProductJob.perform_now(self.id.to_s)
  end
end