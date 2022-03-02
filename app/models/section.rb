class Section < ApplicationRecord
  belongs_to :recipe

  has_many :recipe_ingredients
  has_many :steps
  has_many :recipe_equipments

  validates :name, presence: true,
                   length: { maximum: 100 }
  validates :sort_number, presence: true
end
