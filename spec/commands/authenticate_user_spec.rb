require 'rails_helper'

RSpec.describe AuthenticateUser do
    subject(:context) { described_class.call(email, password) }
    let(:user) { create(:user) }

    describe '.call' do
        context 'when the context is successful' do
            let(:email) { user.email }
            let(:password) { user.password }

            it 'succeeds' do
                expect(context).to be_success
            end
        end

        context 'when the context is not successful' do
            let(:email) { 'wrong_email' }
            let(:password) { 'wrong_password' }

            it 'fails' do
                expect(context).to be_failure
            end
        end
    end
end
