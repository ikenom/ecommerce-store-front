class Vendor
  include Mongoid::Document

  field :business_name, type: String

  belongs_to :user

  validates :business_name, presence: true
end