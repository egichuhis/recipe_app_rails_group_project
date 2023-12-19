Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    resources :foods
    resources :recipes do
      collection do
        get 'public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'
        get 'my_recipes', to: 'recipes#my_recipes', as: 'my_recipes'
      end
      resources :recipe_foods, only: [:new, :create] # nested recipe_foods routes
    end
  end

  root 'foods#index'

  get '/public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'
  get '/my_recipes', to: 'recipes#my_recipes', as: 'my_recipes'
end