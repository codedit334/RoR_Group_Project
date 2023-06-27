Rails.application.routes.draw do
  devise_for :users

  # Add the following route for signing out
  resources :users, only: [:show]

  resources :recipes, except: [:update]
  resources :public_recipes, except: [:update]

  get '/public_recipes', to: 'public_recipes#index'

  # Defines the root path route ("/")
  root 'public_recipes#index'
end
