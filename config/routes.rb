Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  resources :microposts
  get "users/new"
  get "sessions/new"
  root "static_pages#home"
  get "static_pages/home"
  get "static_pages/404"
  get "static_pages/contact"
  get "static_pages/help"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  match "/signup", to: "users#new", via: "get"
  resources :users
end
