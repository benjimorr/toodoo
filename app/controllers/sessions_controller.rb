class SessionsController < ApplicationController
    skip_before_action :authenticate_request, only: :create

    def create
        command = AuthenticateUser.call(auth_params[:email], auth_params[:password])

        if command.success?
            json_response(auth_token: command.result)
        else
            json_response({ error: command.errors }, :unauthorized)
        end
    end

    private

    def auth_params
        params.permit(:email, :password)
    end
end
