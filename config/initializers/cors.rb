Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        origins 'localhost:8080'

        resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end

    allow do
        origins 'my-toodoo.herokuapp.com'

        resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
end
