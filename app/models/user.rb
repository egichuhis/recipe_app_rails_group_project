class User < ApplicationRecord
  has_many :foods, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :recipe_foods, through: :recipes

  validates :name, :email, presence: true
end
