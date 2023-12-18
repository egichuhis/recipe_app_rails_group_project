Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    resources :foods
    resources :recipes
  end

  root 'foods#index'
end
