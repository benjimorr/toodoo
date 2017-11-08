require 'rails_helper'

RSpec.describe 'Users', type: :request do
    describe 'POST #create' do
        let(:user) { build(:user) }
        let(:signup_headers) { valid_headers.except('Authorization') }
        let(:valid_signup_attributes) do
            attributes_for(:user, password_confirmation: user.password)
        end

        context 'when the request is valid' do
            before { post '/users', params: valid_signup_attributes.to_json, headers: signup_headers }

            it 'creates a new user' do
                expect(response).to have_http_status(201)
            end

            it 'returns success message' do
                expect(json['message']).to match('Account created successfully')
            end

            it 'returns an authentication token' do
                expect(json['auth_token']).not_to be_nil
            end
        end

        context 'when the request is invalid' do
            before { post '/users', params: {}, headers: signup_headers }

            it 'returns http failure' do
                expect(response).to have_http_status(422)
            end

            it 'does not create a new user' do
                expect(User.count).to eq 0
            end

            it 'returns failure message' do
                expect(json['message']).to match('Account could not be created')
            end
        end
    end

    describe 'GET #show' do
        let(:user) { create(:user) }

        context 'when the request is valid' do
            before { get '/users/me', headers: valid_headers }

            it 'returns http success' do
                expect(response).to have_http_status(200)
            end

            it 'returns the users id' do
                expect(json['user_id']).to eq(user.id)
            end

            it 'returns the users name' do
                expect(json['name']).to eq(user.name)
            end

            it 'returns the users email' do
                expect(json['email']).to eq(user.email)
            end
        end

        context 'when the request headers are invalid' do
            before { get '/users/me', headers: invalid_headers }

            it 'returns http failure' do
                expect(response).to have_http_status(401)
            end
        end
    end

    describe 'PUT #update' do
        let(:user) { create(:user) }
        let(:new_attributes) do
            {
                name: "Test Name",
                email: "test@example.com",
                password: "newpassword",
                password_confirmation: "newpassword"
            }
        end

        context 'when the request is valid' do
            before { put "/users/#{user.id}", params: new_attributes.to_json, headers: valid_headers }

            it 'returns http success' do
                expect(response).to have_http_status(200)
            end

            it 'returns success message' do
                expect(json['message']).to match('User updated successfully')
            end

            it 'updates user with expected attributes' do
                expect(json['user']['name']).to eq(new_attributes[:name])
                expect(json['user']['email']).to eq(new_attributes[:email])
            end
        end

        context 'when the user attributes are invalid' do
            before { put "/users/#{user.id}", params: {}, headers: valid_headers }

            it 'returns http failure' do
                expect(response).to have_http_status(422)
            end

            it 'does not update the user' do
                expect(user.name).to_not eq(new_attributes[:name])
                expect(user.email).to_not eq(new_attributes[:email])
            end

            it 'returns failure message' do
                expect(json['message']).to match('An error occurred while trying to save user. Please try again.')
            end
        end
    end

    describe 'DELETE #destroy' do
        let(:user) { create(:user) }

        context 'when the request is valid' do
            before { delete "/users/#{user.id}", headers: valid_headers }

            it 'returns http success' do
                expect(response).to have_http_status(200)
            end

            it 'returns success message' do
                expect(json['message']).to match('Account removed successfully')
            end

            it 'deletes the user' do
                count = User.where({id: user.id}).size
                expect(count).to eq 0
            end
        end

        context 'when the user is invalid' do
            before { delete '/users/0', headers: valid_headers }

            it 'returns http not found' do
                expect(response).to have_http_status(404)
            end

            it 'returns record not found error' do
                expect(json['message']).to match("Couldn't find User with 'id'=")
            end
        end
    end
end
