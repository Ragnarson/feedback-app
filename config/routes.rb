Rails.application.routes.draw do
  match "/auth/:provider/callback", to: "sessions#create", via: %i[get post]
  get "/logout", to: "sessions#destroy", as: :logout
  get "/login", to: "users#login", as: :login
  post "/both_creation", to: "request_feedbacks#both_creation", as: :both_creation
  get "/summary", to: "users#summary", as: :summary
  get "/admin_summary", to: "users#admin_summary", as: :admin_summary

  
  root 'users#index'
  resources :users

  resources :give_feedbacks, only: %i[create destroy] do
    member do
      patch :accept
      patch :decline
      patch :happened
      patch :user_offer_happened
    end
  end

  resources :request_feedbacks, only: %i[create destroy] do
    member do
      patch :accept
      patch :decline
      patch :happened
      patch :user_request_happened
    end
  end
end
