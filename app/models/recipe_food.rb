class RecipeFood < ApplicationRecord
  belongs_to :food, foreign_key: 'food_id', inverse_of: :recipe_foods
  belongs_to :recipe, foreign_key: 'recipe_id', inverse_of: :recipe_foods

  validates_presence_of :quantity

  before_save :calculate_value

  def calculate_value
    self.value = quantity * food.price
  end
end
