class Tag < ApplicationRecord
  has_many :recipe_tags
  has_many :recipes, through: :recipe_tags

  validates :name, presence: true,
                   length: { maximum: 100 }
  validates :color,
            length: { maximum: 100 }
end
