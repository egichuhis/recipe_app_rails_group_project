class User < ApplicationRecord
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable
  has_many :foods, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :recipe_foods, through: :recipes

  validates :name, :email, presence: true
end
