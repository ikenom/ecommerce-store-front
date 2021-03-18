module Shopify
  class CustomerService
    class UserCreationError < RuntimeError; end

    attr_reader :client

    def initialize
      @client = Client.new
    end

    CREATE_SHOPIFY_CUSTOMER_QUERY = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
      mutation($email: String!, $firstName: String!, $lastName: String, $phone: String, $tags: [String!]) {
          customerCreate(
            input: {
              email: $email,
              firstName: $firstName,
              lastName: $lastName,
              phone: $phone,
              tags: $tags
            }) {
                customer {
                  id
                  firstName
                  lastName
                  email
                  phone
                }
                userErrors {
                  field
                  message
                }
            }
        }
    GRAPHQL

    def create_customer(first_name:, last_name:, email:, phone:, tags:)
      result = client.shopify_query(CREATE_SHOPIFY_CUSTOMER_QUERY, {
                              "email" => email,
                              "firstName" => first_name,
                              "lastName" => last_name,
                              "phone" => phone,
                              "tags" => tags
                            })

      if result["customerCreate"]["userErrors"].any?
        result["customerCreate"]["userErrors"].each do |error|
          raise EmailExistsError if error["message"].include?("Email has already been taken")
          raise PhoneNumberExistsError if error["message"].include?("Phone has already been taken")
        end

        messages = result["customerCreate"]["userErrors"].map { |error| error["message"] }.join("\n")
        raise UserCreationError, messages
      end

      result["customerCreate"]["customer"]
    end
  end
end