Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/home"
  get "static_pages/404"
  get "static_pages/contact"
  get "static_pages/help"
  get  "/signup",  to: "users#new"
  post "/signup", to: "users#create"
  match "/signup",  to: "users#new", via: "get"
  resources :users
end
