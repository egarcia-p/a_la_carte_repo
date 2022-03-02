class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :section
  belongs_to :uom

  validates :recipe_id, presence: true
  validates :ingredient_id, presence: true
  validates :quantity, presence: true
  validates :uom_id, presence: true
  validates :section_id, presence: true
end
