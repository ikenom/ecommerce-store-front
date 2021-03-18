module Types
  class VendorType < Types::BaseObject
    implements GraphQL::Types::Relay::Node

    global_id_field :id
    field :user, UserType, null: false
    field :business_name, String, null: false
    field :phone_number, String, null: false
  end
end
