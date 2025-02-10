# frozen_string_literal: true

class Step < ApplicationRecord
  belongs_to :section

  validates :description,
            length: { maximum: 100 }
  validates :step_number, presence: true
end
