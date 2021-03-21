# frozen_string_literal: true

module Shopify
  class ProductService
    attr_reader :client

    def initialize
      @client = Client.new
    end

    CREATE_PRODUCT_QUERY = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
      mutation($vendor: String!, $title: String!, $tags: [String!], $productType: String) {
        productCreate(input: {vendor: $vendor, title: $title, tags: $tags, productType: $productType}) {
          product {
            id
            title
            variants(first: 1) {
              edges {
                node {
                  id
                }
              }
            }
          }
        }
      }
    GRAPHQL

    def create_product(name, vendor_name, type, tags)
      response = client.shopify_query(CREATE_PRODUCT_QUERY, {
        vendor: vendor_name,
        title: name,
        tags: tags,
        productType: type
      })
      response["productCreate"]["product"]
    end

    UPDATE_PRODUCT_QUERY = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
      mutation($id: ID!, $price: Money!) {
        productVariantUpdate(input: {id: $id, price: $price}) {
          productVariant {
            price
          }
        }
      }
    GRAPHQL

    def update_product(variant_id, price)
      response = client.shopify_query(UPDATE_PRODUCT_QUERY, {
        price: price,
        id: variant_id
      })
      response["productVariantUpdate"]["productVariant"]
    end
  end
end
