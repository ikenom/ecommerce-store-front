module Mutations
  class Login < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: false

    def resolve(**attributes)
      auth_service = AuthService.new
      login = auth_service.login(attributes[:email], attributes[:password])

      {
        token: login.token
      }
    end
  end
end