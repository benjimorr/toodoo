class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: :create

    def show
        user = User.find(@current_user.id)
        response = {
            user_id: user.id,
            name: user.name,
            email: user.email
        }
        json_response(response, :ok)
    end

    def create
        user = User.new(user_params)
        if user.save
            auth_token = AuthenticateUser.call(user.email, user.password)
            response = { message: Message.account_created, auth_token: auth_token }
            json_response(response, :created)
        else
            response = { message: Message.account_not_created, errors: user.errors }
            json_response(response, 422)
        end
    end

    def update
        user = User.find(params[:id])
        user.assign_attributes(user_params)

        if user.save
            response = { message: Message.user_updated, user: user }
            json_response(response, :ok)
        else
            response = { message: Message.user_not_saved, errors: user.errors}
            json_response(response, 422)
        end
    end

    def destroy
        user = User.find(params[:id])

        if user.destroy
            response = { message: Message.account_removed }
            json_response(response, :ok)
        else
            response = { message: Message.account_not_removed }
        end
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
