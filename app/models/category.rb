# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :recipes
  has_many :subcategories

  validates :name, presence: true,
                   length: { maximum: 100 }
end
