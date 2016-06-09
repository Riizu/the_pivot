Rails.application.routes.draw do
  root to: "home#show"

  resources :users, only: [:new, :create, :show]

  resources :socks, only: [:index, :show]

  resources :cart_socks, only: [:create, :destroy, :update]

  get "/orders", to: "orders#index"

  get "/cart", to: "cart_socks#show"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/dashboard", to: "users#show"

  get "/:id", to: "navigations#show"
end
