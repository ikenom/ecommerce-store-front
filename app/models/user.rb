class User
  include Mongoid::Document

  field :auth_id, type: String
  field :ec_id, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :phone_number, type: String

  validates :auth_id, :first_name, :last_name, :email, :phone_number, presence: true
end