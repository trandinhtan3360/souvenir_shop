Rails.application.routes.draw do
  get 'set_language/english'

  get 'set_language/vietnam'

  root "static_pages#home"
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

  scope "(:locale)", :locale => /en|vn/ do
    root "static_pages#home"
  end
end
