# app/controllers/recipes_controller.rb

class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.where(is_public: true)
  end

  def my_recipes
    @recipes = current_user.recipes.includes(:user)
    render 'my_recipes'
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new, alert: 'Failed to create recipe.'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete recipe.'
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: 'Recipe was successfully updated.'
    else
      render :edit, alert: 'Failed to update recipe.'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :is_public)
  end
end
