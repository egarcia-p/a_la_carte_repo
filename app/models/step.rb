# frozen_string_literal: true

class Step < ApplicationRecord
  belongs_to :recipe
  belongs_to :section

  validates :description,
            length: { maximum: 100 }
  validates :step_number, presence: true
  validates :section_id, presence: true
  validates :recipe_id, presence: true
end
