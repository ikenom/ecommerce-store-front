module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_vendor, mutation: Mutations::CreateVendor
    field :create_draft_order, mutation: Mutations::CreateDraftOrder
    field :login, mutation: Mutations::Login
    field :checkout, mutation: Mutations::Checkout
  end
end
