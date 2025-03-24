# frozen_string_literal: true

class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true,
                   length: { maximum: 100 }
  validates :fdc_id, uniqueness: true, allow_nil: true


  def self.find_or_create_by_fdc_id(fdc_id, name)
    ingredient = Ingredient.find_by(fdc_id: fdc_id)
    return ingredient if ingredient

    ingredient = Ingredient.new(fdc_id: fdc_id, name: name, description: name)
    ingredient.save
    ingredient
  end
end
