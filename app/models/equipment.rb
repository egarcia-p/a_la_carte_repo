class Equipment < ApplicationRecord
  has_many :recipe_equipments

  validates :name, presence: true,
                   length: { maximum: 255 }
  validates :material,
            length: { maximum: 100 }
end
