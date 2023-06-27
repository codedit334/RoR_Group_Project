Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :recipes, except: [:update]
  resources :foods, except: [:update]

  root to: 'recipes#index'
end
