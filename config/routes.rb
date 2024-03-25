Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root to: "listings#index"

  resources :users, only: [:show]

  resources :bookings, only: [:index , :show, :destroy, :update] do
    resources :reviews, only: [:new, :create ]
  end

  resources :listings, only:[ :index, :show, :new, :create, :edit, :update, :destroy, :my_listings] do
    resources :bookings, only: [ :new, :create]
    collection do
      get :my_listings
    end
  end
  resources :favorite_listings, only:[:index, :create, :destroy]

end
