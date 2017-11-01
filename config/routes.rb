Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    post 'authenticate', to: 'authentication#authenticate'

    resources :users, only: [:create, :update, :destroy]
    get 'get_me', to: 'users#get_me'
end
