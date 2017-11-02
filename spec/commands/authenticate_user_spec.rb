require 'rails_helper'

RSpec.describe AuthenticateUser do
    subject(:context) { described_class.call(email, password) }
    let(:user) { create(:user) }

    describe '#call' do
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

            it 'raises an authentication error' do
                expect(context).to raise_error(ExceptionHandler::AuthenticationError)
            end
        end
    end
end
