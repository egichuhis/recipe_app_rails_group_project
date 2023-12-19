# app/controllers/recipes_controller.rb

class RecipesController < ApplicationController
  before_action :authenticate_user!

  def public_recipes
    @recipes = Recipe.where(is_public: true)
    render 'public_recipes'
  end

  def private_recipes
    @recipes = current_user.recipes.where(is_public: false)
    render 'private_recipes'
  end
end
