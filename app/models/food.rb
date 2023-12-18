class Food < ApplicationRecord
  has_many :recipes_foods, inverse_of: :food, dependent: :destroy
  has_many :recipes, through: :recipes_foods

  validates :name, :measurement_unit, :price, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true }
end
