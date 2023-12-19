class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipes_foods, inverse_of: :recipe, dependent: :destroy
  has_many :foods, through: :recipes_foods

  validates :is_public, inclusion: { in: [true, false] }
  validates :name, :preparation_time, :cooking_time, presence: true
  validates :preparation_time, :cooking_time, numericality: { only_integer: true }

  def total_price
    foods.sum(:price)
  end
end
