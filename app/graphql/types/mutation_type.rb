module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_vendor, mutation: Mutations::CreateVendor
    field :create_draft_order, mutation: Mutations::CreateDraftOrder
    field :create_product, mutation: Mutations::CreateProduct
    field :login, mutation: Mutations::Login
    field :checkout, mutation: Mutations::Checkout
    field :complete_fulfillment, mutation: Mutations::CompleteFulfillment
    field :start_fulfillment, mutation: Mutations::StartFulfillment
    field :pause_fulfillment, mutation: Mutations::PauseFulfillment
    field :cancel_fulfillment, mutation: Mutations::CancelFulfillment
  end
end
