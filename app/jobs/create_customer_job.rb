class CreateCustomerJob < ApplicationJob
  queue_as :ecsf_create_customer

  def perform(user_id)
    user = User.find(user_id)

    customer_service = Shopify::CustomerService.new
    customer = customer_service.create_customer(
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      phone: user.phone_number,
      tags: [])

    user.update!(ec_id: customer["id"])
  end
end