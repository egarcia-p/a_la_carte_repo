# frozen_string_literal: true

class Uom < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipe_equipments

  validates :name, presence: true,
                   length: { maximum: 100 }
  validates :base_unit, presence: true,
                        length: { maximum: 100 }
  validates :system, presence: true,
                     length: { maximum: 10 }
  validates :system, length: { maximum: 10 }
end
