require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
    let(:user) { create(:user) }
    # Mock `Authorization` header
    let(:header) { { 'Authorization' => token_generator(user.id) } }

    subject(:invalid_request_obj) { described_class.call({}) }
    subject(:request_obj) { described_class.call(header) }

    describe '#call' do
        context 'when the request is valid' do
            it 'returns the user object' do
                expect(request_obj.result[:user]).to eq(user)
            end
        end

        context 'when the request is invalid' do
            context 'when missing token' do
                it 'raises a MissingToken error' do
                    expect { invalid_request_obj }.to raise_error(ExceptionHandler::MissingToken, 'Missing token')
                end
            end

            context 'when invalid token' do
                subject(:invalid_request_obj) do
                    # custom helper method `token_generator`
                    described_class.call('Authorization' => token_generator(5))
                end

                it 'raises an InvalidToken error' do
                    expect { invalid_request_obj }.to raise_error(ExceptionHandler::InvalidToken, 'Invalid token')
                end
            end

            context 'when token is expired' do
                let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
                subject(:request_obj) { described_class.call(header) }

                it 'raises an ExpiredSignature error' do
                    expect { request_obj }.to raise_error(ExceptionHandler::ExpiredSignature, 'Signature has expired')
                end
            end
        end
    end
end
