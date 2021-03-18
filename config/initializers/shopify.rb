# frozen_string_literal: true

api_key = ENV["SHOPIFY_API_KEY"]
api_password = ENV["SHOPIFY_API_PASSWORD"]
shop_name = ENV["SHOPIFY_SHOP_NAME"]

ShopifyAPI::Base.site = "https://#{api_key}:#{api_password}@#{shop_name}.myshopify.com"
ShopifyAPI::Base.api_version = "2021-01" # find the latest stable api_version here: https://shopify.dev/concepts/about-apis/versioning
