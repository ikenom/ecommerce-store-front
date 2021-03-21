module Shopify
  class UpdateProductJob < ApplicationJob
    queue_as :ecfs_shopify_update_product

    def perform(product_id)
      product = Product.find(product_id)
      ProductService.new.update_product(product.shopify_variant_id, product.price)
    end
  end
end