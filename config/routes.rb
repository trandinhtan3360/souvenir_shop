Rails.application.routes.draw do
  
  get "products/index"
  root "static_pages#home"
  get "static_pages/home"
  get "static_pages/404"
  get "static_pages/contact"
  get "static_pages/help"
  get "password_resets/new"
  post "/password_resets", to: "password_resets#new"
  get "password_resets/edit"
  get  "/signup",  to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  match "/signup",  to: "users#new", via: "get"

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users
  resources :categories
  resources :products
  resources :comments
  resources :orders
  resources :order_details
  resources :payment_methods
  resources :transactions

  namespace :admin do
    root "users#home"
    resources :users, only: [:index, :show, :destroy, :edit]
  end

  namespace :admin do
    root "products#index"
    resources :products
 end

 namespace :admin do
  resources :categories
 end

end

