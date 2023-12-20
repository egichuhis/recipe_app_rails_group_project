class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, inverse_of: :recipe, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :is_public, inclusion: { in: [true, false] }
  validates :name, :preparation_time, :cooking_time, presence: true
  validates :preparation_time, :cooking_time, numericality: { only_integer: true }

  def recipes_total_price
    recipe_foods.sum { |rf| rf.food.price * rf.quantity }
  end
end
