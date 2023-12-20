# app/controllers/recipe_foods_controller.rb

class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build(recipe_foods_params)

    if @recipe_food.save
      redirect_to @recipe, notice: 'Ingredient added successfully.'
    else
      render 'recipe_foods/new'
    end
  end

  private

  def recipe_foods_params
    params.require(:recipe_food).permit(:food_id, :quantity, recipe_foods: %i[food_id quantity])
  end
end
