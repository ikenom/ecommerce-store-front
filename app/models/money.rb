class Money
  include Mongoid::Document

  field :amount, type: Float
  field :currency, type: String

  embedded_in :order
end