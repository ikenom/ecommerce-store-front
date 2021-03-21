# frozen_string_literal: true

module Shopify
  class OrderService
    attr_reader :client

    def initialize
      @client = Client.new
    end

    CREATE_DRAFT_ORDER_QUERY = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
      mutation($customerId: ID!, $lineItems: [DraftOrderLineItemInput!]!) {
        draftOrderCreate(input: {customerId: $customerId, lineItems: $lineItems}) {
          draftOrder {
            id
          }
        }
      }
    GRAPHQL

    def create_draft_order(customer_id, line_item_attributes)
      response = client.shopify_query(CREATE_DRAFT_ORDER_QUERY, {
        customerId: customer_id,
        lineItems: line_item_attributes,
      })
      response["draftOrderCreate"]["draftOrder"]
    end

    COMPLETE_DRAFT_ORDER_QUERY = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
      mutation($draftOrderId: ID!) {
        draftOrderComplete(id: $draftOrderId) {
          draftOrder {
            order {
              id
            }
          }
        }
      }
    GRAPHQL

    def complete_draft_order(draft_order_id)
      response = client.shopify_query(COMPLETE_DRAFT_ORDER_QUERY, {
        draftOrderId: draft_order_id
      })
      response["draftOrderComplete"]["draftOrder"]
    end

    ORDER_QUERY = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
      query($orderId: ID!) {
        order(id: $orderId) {
          id
          createdAt
          cancelledAt
          closedAt
          totalPriceSet {
            presentmentMoney {
              amount
              currencyCode
            }
          }
          fulfillmentOrders(first: 1) {
            edges {
              node {
                status
              }
            }
          }
        }
      }
    GRAPHQL

    def order(order_id)
      response = client.shopify_query(ORDER_QUERY, {
        orderId: order_id,
      })

      response["order"]
    end
  end
end
