Rails.application.routes.draw do
  resources :products, only: [:index]
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  root to: "products#index"
  #root "static_pages#home"
  get "static_pages/home"
  get "static_pages/404"
  get "static_pages/contact"
  get "static_pages/help"
  get  "/signup",  to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  match "/signup",  to: "users#new", via: "get"
  resources :users
end
