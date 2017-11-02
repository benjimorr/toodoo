class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: :create

    def create
        user = User.create!(user_params)
        auth_token = AuthenticateUser.call(user.email, user.password)
        response = { message: Message.account_created, auth_token: auth_token }
        json_response(response, :created)
    end

    def update
    end

    def destroy
    end

    private

    def user_params
        params.permit(
            :name,
            :email,
            :password,
            :password_confirmation
        )
    end
end
