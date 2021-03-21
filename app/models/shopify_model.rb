require "active_support/concern"

module ShopifyModel
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document

    field :shopify_id, type: String
  end
end