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

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe

    if @recipe_food.destroy
      redirect_to @recipe, notice: 'Ingredient removed successfully.'
    else
      redirect_to @recipe, alert: 'Failed to remove ingredient.'
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe

    if @recipe_food.update(recipe_foods_params)
      redirect_to @recipe, notice: 'Ingredient modified successfully.'
    else
      render 'edit'
    end
  end

  private

  def recipe_foods_params
    params.require(:recipe_food).permit(:food_id, :quantity, recipe_foods: %i[food_id quantity])
  end
end
