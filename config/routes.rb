Rails.application.routes.draw do

  devise_for :users

  get 'foods/index'
  get 'foods/show'
  get 'foods/new'
  get 'foods/create'
  get 'foods/edit'
  get 'foods/destroy'

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  resources :recipes, except: [:update]
  


  root to: 'recipes#index'

  # root to: "home#index"

  resources :foods, except: [:update]
end
