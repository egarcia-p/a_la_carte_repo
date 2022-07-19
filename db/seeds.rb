# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
p 'Enter'
Category.create(name: 'Category 1')
Subcategory.create(name: 'Category 1', category_id: 1)

category = Category.first
subcategory = Subcategory.first

9.times do |i|
  p 'Recipe 1'
  rec = Recipe.new(title: "Recipe #{i + 1}", servings: 1, total_time: 60, author: 'EG')
  rec.category_id = category.id
  rec.subcategory_id = subcategory.id
  p "Valid? #{rec.valid?}"
  p rec.errors.full_messages
  rec.save
end
