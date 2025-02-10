# frozen_string_literal: true

class Recipe < ApplicationRecord
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags
  has_many :steps, through: :sections
  has_many :sections
  has_many :recipe_ingredients, through: :sections
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_equipments
  has_many :equipments, through: :recipe_equipments

  belongs_to :category
  belongs_to :subcategory

  validates :title, presence: true,
                    length: { maximum: 255 }
  validates :subtitle,
            length: { maximum: 255 }
  validates :servings, presence: true
  validates :total_time, presence: true
  validates :author,
            length: { maximum: 255 }
  validates :category_id, presence: true
  validates :subcategory_id, presence: true

  accepts_nested_attributes_for :sections, allow_destroy: true
end
