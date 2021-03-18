class CreateUserJob < ApplicationJob
  queue_as :ecsf_create_user

  def perform(password:, **attributes)\
    auth_service = AuthService.new
    phone_number = attributes[:phone_number].tr('^0-9', '')

    raise Errors::PhoneInvalid unless Phonelib.valid?(phone_number)
    raise Errors::PhoneTaken if User.where(phone_number: phone_number).exists?
    raise Errors::EmailInvalid unless attributes[:email].match?(/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    raise Errors::EmailExists if User.where(email: attributes[:email]).exists?

    response = auth_service.create_user(
      email: attributes[:email],
      password: password,
      display_name: display_name(attributes[:first_name], attributes[:last_name]))

    user = User.create!(auth_id: response.user.id, **attributes)
    CreateCustomerJob.perform_later(user.id.to_s)
    {
      token: response.token,
      user: user
    }
  end
end