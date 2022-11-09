Rails.application.routes.draw do
  match "/auth/:provider/callback", to: "sessions#create", via: %i[get post]
  get "/logout", to: "sessions#destroy", as: :logout
  get "/login", to: "users#login", as: :login
  post "/both_creation", to: "request_feedbacks#both_creation", as: :both_creation
  
  root 'users#index'
  resources :users

  resources :give_feedbacks, only: %i[create destroy] do
    member do
      patch :accept
      patch :decline
    end
  end

  resources :request_feedbacks, only: %i[create destroy] do
    member do
      patch :accept
      patch :decline
    end
  end
end
