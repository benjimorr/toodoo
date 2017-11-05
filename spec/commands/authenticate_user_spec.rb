require 'rails_helper'

RSpec.describe AuthenticateUser do
    let(:user) { create(:user) }

    subject(:invalid_request_obj) { described_class.call('wrong_email', 'wrong_password') }
    subject(:request_obj) { described_class.call(user.email, user.password) }

    describe '#call' do
        context 'when the context is successful' do
            it 'succeeds' do
                expect(request_obj).to be_success
            end
        end

        context 'when the context is not successful' do
            it 'raises an authentication error' do
                expect { invalid_request_obj }.to raise_error(ExceptionHandler::AuthenticationError, 'Invalid credentials')
            end
        end
    end
end
