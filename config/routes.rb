Rails.application.routes.draw do
    get '/users/me' => 'users#show'
    resources :users, only: [:create, :update, :destroy]
    resources :sessions, only: [:create]

    resources :todos, except: [:new, :edit] do
        resources :items, only: [:create, :update, :destroy]
    end

    root 'todos#index'
end
