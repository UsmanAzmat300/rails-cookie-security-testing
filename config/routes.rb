Rails.application.routes.draw do
  root "sessions#new"

  get    "login",  to: "sessions#new",     as: :login
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  get "protected", to: "protected#show", as: :protected
end