Rails.application.routes.draw do
  devise_for :users

  resources :recipes, except: [:update]
  

  root to: 'recipes#index'
end
