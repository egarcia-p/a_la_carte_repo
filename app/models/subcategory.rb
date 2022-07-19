# frozen_string_literal: true

class Subcategory < ApplicationRecord
  has_many :recipes

  validates :name, presence: true,
                   length: { maximum: 100 }
  validates :category_id, presence: true
end
