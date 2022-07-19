# frozen_string_literal: true

class RecipeEquipment < ApplicationRecord
  belongs_to :recipe
  belongs_to :section
  belongs_to :uom
  belongs_to :equipment

  validates :recipe_id, presence: true
  validates :equipment_id, presence: true
  validates :quantity, presence: true
  validates :section_id, presence: true
end
