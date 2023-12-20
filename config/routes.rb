Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    resources :foods
    resources :recipes do
      collection do
        get 'public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'
        get 'my_recipes', to: 'recipes#my_recipes', as: 'my_recipes'
      end

      member do
        get 'shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
      end

      resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  root 'foods#index'

  get '/public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'
  get '/my_recipes', to: 'recipes#my_recipes', as: 'my_recipes'
  get '/shopping_list', to: 'shopping_list#general', as: 'general_shopping_list'
end