class User < ApplicationRecord
    before_save { self.email = email.downcase }

    validates :name, presence: true, length: { minimum: 5, maximum: 50 }
    validates :password, presence: true, length: { minimum: 8 }
    validates :email,
        presence: true,
        uniqueness: { case_sensitive: false },
        length: { minimum: 5, maximum: 30 }

    has_secure_password
end
