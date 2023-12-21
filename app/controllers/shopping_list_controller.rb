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
    recipe_foods = RecipeFood.joins(:food, :recipe).where(foods: { user_id: user.id })

    # Identify deficit items
    deficit_items = []
    recipe_foods.each do |rf|
      user_food = user_foods.find { |uf| uf == rf.food }
      deficit_quantity = [rf.quantity - user_food.quantity, 0].max
      deficit_items << { food: user_food, deficit_quantity: } if deficit_quantity.positive?
    end

    deficit_items
  end

  def calculate_total_price(missing_foods)
    missing_foods.sum { |item| item[:food].price * item[:deficit_quantity] }
  end
end
