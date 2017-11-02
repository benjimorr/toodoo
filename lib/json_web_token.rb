# Create a singleton class by using class << self within the initial class
class JsonWebToken
    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def self.decode(token)
        body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
        HashWithIndifferentAccess.new body
    rescue JWT::ExpiredSignature, JWT::VerificationError => e
        # raise custom error to be handled by custom handler
        raise ExceptionHandler::ExpiredSignature, e.message
    end
end
