Rails.application.routes.draw do
  devise_for :users
  root to: "properties#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Defines the root path route ("/")
  # root "posts#index"
  resources :properties do
    resources :reservations, only: %i[new create]
  end
  resources :dashboard do
    resources :properties, only: %i[new create]
    resources :reservations, only: %i[index show update]
  end
  get "/profile", to: "dashboard#profile"
end
