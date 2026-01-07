# frozen_string_literal: true

class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true,
                   length: { maximum: 100 }
  def self.find_or_create_by_name(name)
    ingredient = Ingredient.find_by(name: name)
    return ingredient if ingredient

    ingredient = Ingredient.new(name: name)
    ingredient.save
    ingredient
  end
end
