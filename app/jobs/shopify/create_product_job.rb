module Shopify
  class CreateProductJob < ApplicationJob
    queue_as :ecfs_shopify_create_product

    def perform(product_id)
      product = Product.find(product_id)
      shopify_product = ProductService.new.create_product(product.name, "test", product.type, [])
      product.update!(shopify_id: shopify_product["id"], shopify_variant_id: shopify_product["variants"]["edges"].first["node"]["id"])

      UpdateProductJob.perform_now(product_id)
    end
  end
end