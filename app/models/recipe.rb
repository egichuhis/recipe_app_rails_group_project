class Recipe < ApplicationRecord
  has_many :recipes_foods, inverse_of: :recipe, dependent: :destroy
  has_many :foods, through: :recipes_foods

  validates :is_public, inclusion: { in: [true, false] }
  validates :name, :preparation_time_minutes, :cooking_time_minutes, presence: true
  validates :preparation_time_minutes, :cooking_time_minutes, numericality: { only_integer: true }
end
