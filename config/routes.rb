Rails.application.routes.draw do
    post 'login', to: 'authentication#authenticate'

    post 'signup', to: 'users#create'
    get 'profile', to: 'users#profile'

    resources :users, only: [:update, :destroy]
end
