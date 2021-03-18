module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_vendor, mutation: Mutations::CreateVendor
    field :login, mutation: Mutations::Login
  end
end
