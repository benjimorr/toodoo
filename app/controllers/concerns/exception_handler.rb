# This module handles RecordNotFound and RecordInvalid exceptions that may arise by looking up non-existent models or creating invalid models
module ExceptionHandler
    extend ActiveSupport::Concern

    # Define custom error subclasses - rescue catches `StandardErrors`
    class AuthenticationError < StandardError; end
    class MissingToken < StandardError; end
    class InvalidToken < StandardError; end
    class ExpiredSignature < StandardError; end

    included do
        # Defining custom handlers
        rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
        rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
        rescue_from ExceptionHandler::MissingToken, with: :unauthorized_request
        rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
        rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight

        rescue_from ActiveRecord::RecordNotFound do |e|
            json_response({ message: e.message }, :not_found)
        end
    end

    private

    # JSON response for status code 422 - unprocessable entity
    def four_twenty_two(e)
        json_response({ message: e.message }, :unprocessable_entity)
    end

    # JSON response for status code 498 - invalid token
    def four_ninety_eight(e)
        json_response({ message: e.message }, :invalid_token)
    end

    # JSON response for status code 401 - Unauthorized
    def unauthorized_request(e)
        json_response({ message: e.message }, :unauthorized)
    end
end
