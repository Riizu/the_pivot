Rails.application.routes.draw do
  root to: "home#show"

  resources :users, only: [:new, :create, :edit, :update]

  resources :spaces, only: [:index]

  resources :cart_socks, only: [:create, :destroy, :update]

  resources :orders, only: [:index, :show, :create]

  resources :tweets, only: [:new, :create]

  resources :charges, only: [:new, :create]

  get "/cart", to: "cart_socks#show"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/dashboard", to: "users#show"

  get "/auth/twitter", as: :twitter_login
  get "/auth/twitter/callback", to: "sessions#create"

  namespace :admin do
    get "/dashboard", to: "users#show"
    resources :socks
  end

  get "spaces/:space_slug", to: "spaces#show", as: :space

  get "/:id", to: "navigations#show"
end
