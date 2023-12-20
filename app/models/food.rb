class Food < ApplicationRecord
  has_many :recipe_foods, inverse_of: :food, dependent: :destroy
  has_many :recipes, through: :recipe_foods

  validates :name, :measurement_unit, :price, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true }

  def value
    quantity * price
  end
end
