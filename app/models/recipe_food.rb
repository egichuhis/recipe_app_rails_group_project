class RecipeFood < ApplicationRecord
  belongs_to :food, foreign_key: 'food_id', inverse_of: :recipe_foods
  belongs_to :recipe, foreign_key: 'recipe_id', inverse_of: :recipe_foods

  validates_presence_of :quantity
end
