require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
    let(:user) { create(:user) }

    describe "POST #authenticate" do
        it "returns http success" do
            post :authenticate, {:params => {email: user.email, password: user.password}, :format => :json}
            expect(response).to have_http_status(:success)
        end

        it "returns an auth_token on success" do
            post :authenticate, {:params => {email: user.email, password: user.password}, :format => :json}
            expect(response.body["auth_token"]).to_not be_nil
        end

        it "returns http error with incorrect email" do
            post :authenticate, {:params => {email: "some_email", password: user.password}, :format => :json}
            expect(response.body["error"]).to eq("error")
        end

        it "returns http error with incorrect password" do
            post :authenticate, {:params => {email: user.email, password: "some_password"}, :format => :json}
            expect(response.body["error"]).to eq("error")
        end
    end
end
