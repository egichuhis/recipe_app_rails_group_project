# app/controllers/shopping_list_controller.rb
class ShoppingListController < ApplicationController
  before_action :authenticate_user!

  def general
    @user = current_user
    @missing_foods = calculate_missing_foods(@user)
    @total_items = @missing_foods.count
    @general_total_price = calculate_total_price(@missing_foods)
  end

  private

  def calculate_missing_foods(user)
    # Find all foods associated with the user
    user_foods = user.foods.to_a

    # Find all foods associated with the user's recipes
    recipe_foods = Recipe.joins(:recipe_foods).where(recipe_foods: { food: user_foods })

    # Identify deficit items
    deficit_items = []
    recipe_foods.each do |recipe|
      recipe.recipe_foods.each do |rf|
        user_food = user_foods.find { |uf| uf == rf.food }
        deficit_items << user_food if user_food.quantity < rf.quantity
      end
    end

    deficit_items
  end

  def calculate_total_price(missing_foods)
    missing_foods.sum(&:price)
  end
end
