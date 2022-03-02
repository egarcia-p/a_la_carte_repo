class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true,
                   length: { maximum: 100 }
  validates :uom, presence: true,
                  length: { maximum: 100 }
end