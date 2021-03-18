  require "graphql/client"
  require "graphql/client/http"

  module AuthServiceAPI
    release_name = ENV["RELEASE_NAME"].upcase
    release_name.gsub! "-", "_"

    HOST = ENV["#{release_name}_USER_SERVICE_RAILS_SERVICE_HOST"]
    HTTP = GraphQL::Client::HTTP.new("http://#{HOST}/graphql") do
      def headers(context)
        token = context[:jwt_token]
        {
          "Authorization": "Bearer #{token}",
        }
      end
    end
    Schema = GraphQL::Client.load_schema(HTTP)
    Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
  end


  class AuthService
    CreateUserQuery = AuthServiceAPI::Client.parse <<-'GRAPHQL'
      mutation($email: String!, $password: String!, $displayName: String!) {
        createUser(input: {email: $email, password: $password, displayName: $displayName}) {
          token
          user {
            id
          }
        }
      }
    GRAPHQL

    def create_user(email:, password:, display_name:)
      response = AuthServiceAPI::Client.query(CreateUserQuery, variables: {
        email: email,
        password: password,
        displayName: display_name
      })
      response.data.create_user
    end

    GetUserQuery = AuthServiceAPI::Client.parse <<-'GRAPHQL'
      query {
        user {
          id
        }
      }
    GRAPHQL

    def user(jwt_token:)
      response = AuthServiceAPI::Client.query(GetUserQuery, context: { jwt_token: jwt_token })
      response
    end

    LoginQuery = AuthServiceAPI::Client.parse <<-'GRAPHQL'
      mutation($email: String!, $password: String!) {
        login(input: {email: $email, password: $password}) {
          token
        }
      }
    GRAPHQL

    def login(email, password)
      response = AuthServiceAPI::Client.query(LoginQuery, variables: {
        email: email,
        password: password,
      })
      response.data.login
    end
  end