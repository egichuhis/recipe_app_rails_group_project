# app/controllers/recipe_foods_controller.rb

class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipes_foods.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipes_foods.build(recipe_food_params)

    if @recipe_food.save
      redirect_to @recipe, notice: 'Ingredient added successfully.'
    else
      render 'recipes/add_ingredient'
    end
  end

  private

  def recipes_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
