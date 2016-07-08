Rails.application.routes.draw do
  root to: "home#show"

  get "/api/getplanetnames", to: "home#index"

  resources :users, only: [:new, :create, :update]

  resources :spaces, only: [:index, :new, :create]

  resources :reservations, only: [:create, :destroy, :update]

  resources :orders, only: [:index, :show, :create]

  resources :tweets, only: [:new, :create]

  resources :charges, only: [:new, :create]

  get "/cart", to: "reservations#show"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/dashboard", to: "dashboard#show"

  get "/auth/twitter", as: :twitter_login
  get "/auth/twitter/callback", to: "sessions#create"

  namespace :admin do
    get "/dashboard", to: "users#show"
    resources :spaces, only: [:index, :edit, :update]
    resources :unapproved_spaces, only: [:index, :update]
    resources :reservations, only: [:index, :edit, :update]
    resources :planets, only: [:index, :edit, :update]
    resources :styles, only: [:index, :edit, :update]
    resources :users, only: [:index, :edit, :update]
  end

  get "hosts/:space_slug/new", to: "hosts#new"
  post "/hosts", to: "hosts#create"

  get "spaces/:space_slug", to: "spaces#show", as: :space
  get "spaces/:space_slug/edit", to: "spaces#edit", as: :edit_space
  patch "/spaces/:space_slug", to: "spaces#update"

  get "planets/:planet_slug", to: "planets#show", as: :planet
  patch "/planets/:planets_slug", to: "planets#update"

  get "styles/:style_slug", to: "styles#show", as: :style

  get "users/:username/edit", to: "users#edit", as: :edit_user
  get "/:username", to: "users#show", as: :listings

end
