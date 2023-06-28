Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show]

  resources :recipes, except: [:update] do
    resources :foods, only: [:new, :create, :destroy]
    resources :recipe_foods, only: [:new, :create, :destroy]
    patch 'toggle_public', on: :member
  end

  resources :public_recipes, except: [:update]

  resources :general_shopping_list, only: [:index]

  root 'public_recipes#index'
end
