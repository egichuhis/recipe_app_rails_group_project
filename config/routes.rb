Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    resources :foods
    resources :recipes do
      collection do
        get 'public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'
        get 'private_recipes', to: 'recipes#private_recipes', as: 'private_recipes'
      end
    end
  end

  # Change the root path to '/foods'
  root 'foods#index'

  # Map '/public_recipes' to 'recipes#public_recipes'
  get '/public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'

  # Map '/recipes' to 'recipes#private_recipes'
  get '/private_recipes', to: 'recipes#private_recipes', as: 'private_recipes'
end
