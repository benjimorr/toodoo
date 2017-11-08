Rails.application.routes.draw do
    get '/users/me' => 'users#show'
    resources :users, only: [:create, :update, :destroy]
    resources :sessions, only: [:create]
end
