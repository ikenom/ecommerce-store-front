module Mutations
  class Login < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: false
    field :user, Types::UserType, null: false

    def resolve(**attributes)
      auth_service = AuthService.new
      login = auth_service.login(attributes[:email], attributes[:password])

      {
        token: login.token,
        user: User.find_by(auth_id: login.user.id)
      }
    end
  end
end