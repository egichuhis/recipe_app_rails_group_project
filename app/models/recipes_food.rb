class RecipesFood < ApplicationRecord
  belongs_to :food, foreign_key: 'food_id', inverse_of: :recipes_foods
  belongs_to :recipe, foreign_key: 'recipe_id', inverse_of: :recipes_foods

  validates_presence_of :quantity
end
