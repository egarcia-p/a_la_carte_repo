# frozen_string_literal: true

class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :section
  belongs_to :uom

  validates :ingredient_id, presence: true
  validates :quantity, presence: true
  validates :uom_id, presence: true
end
