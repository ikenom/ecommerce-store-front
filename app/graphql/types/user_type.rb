module Types
  class UserType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :email, String, null: false
    field :phone_number, String, null: false
  end
end
