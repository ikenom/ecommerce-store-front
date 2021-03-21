class Product
  include Mongoid::Document

  field :name, type: String
  field :shopify_variant_id, type: String
  has_many :addons
  has_many :priced_addons, class_name: "Product"
end