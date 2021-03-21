class LineItem
  include Mongoid::Document

  field :quantity, type: Integer

  has_many :addons
  has_many :priced_addons, class_name: "Product"
  belongs_to :product
  belongs_to :draft_order
end