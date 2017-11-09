class Message
    def self.not_found(record = 'record')
        "Sorry, #{record} not found."
    end

    def self.invalid_credentials
        'Invalid credentials'
    end

    def self.invalid_token
        'Invalid token'
    end

    def self.missing_token
        'Missing token'
    end

    def self.expired_token
        'Sorry, your token has expired. Please login to continue.'
    end

    def self.unauthorized
        'Unauthorized request'
    end

    def self.account_created
        'Account created successfully'
    end

    def self.account_not_created
        'Account could not be created'
    end

    def self.account_removed
        'Account removed successfully'
    end

    def self.account_not_removed
        'An error occurred while trying to remove account. Please try again.'
    end

    def self.user_updated
        'User updated successfully'
    end

    def self.user_not_saved
        'An error occurred while trying to save user. Please try again.'
    end

    def self.todo_created
        'To-do list created successfully'
    end

    def self.todo_not_created
        'To-do list could not be created'
    end

    def self.todo_updated
        'To-do list updated successfully'
    end

    def self.todo_not_saved
        'An error occurred while trying to save the to-do list. Please try again.'
    end

    def self.todo_removed
        'To-do list removed successfully'
    end

    def self.todo_not_removed
        'An error occurred while trying to remove the to-do list. Please try again.'
    end
end
