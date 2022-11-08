Rails.application.routes.draw do
  match "/auth/:provider/callback", to: "sessions#create", via: %i[get post]
  get "/logout", to: "sessions#destroy", as: :logout
  
  root 'users#index'
  resources :users
  resources :give_feedbacks, only: %i[create destroy]
  resources :request_feedbacks, only: %i[create destroy]
  patch "/accept_give_feedback/:id", to: "give_feedbacks#accept", as: :accept_give_feedback
  patch "/decline_give_feedback", to: "give_feedbacks#decline", as: :decline_give_feedback
  post "/both_creation", to: "request_feedbacks#both_creation", as: :both_creation
end
