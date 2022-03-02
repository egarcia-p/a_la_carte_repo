class Uom < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipe_equipments

  validates :name, presence: true,
                   length: { maximum: 100 }
  validates :base_unit, presence: true,
                        length: { maximum: 100 }
  validates :type, presence: true,
                   length: { maximum: 10 }
end
