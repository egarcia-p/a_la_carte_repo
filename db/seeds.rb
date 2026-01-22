# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p 'Seeding database'

# Warning - this will delete all records in the database
p 'Warning - this will delete all records in the database'
# gets removed for non-interactive execution

# Seed Categories and Subcategories
puts 'Creating categories and subcategories...'

# Dinner
dinner = Category.create!(name: 'Dinner')
Subcategory.create!([
  { name: 'Pasta Dishes', category_id: dinner.id },
  { name: 'Casseroles', category_id: dinner.id },
  { name: 'Stir-Fry', category_id: dinner.id },
  { name: 'Grilled Dishes', category_id: dinner.id },
  { name: 'One-Pot Meals', category_id: dinner.id }
])

# Snacks
snacks = Category.create!(name: 'Snacks')
Subcategory.create!([
  { name: 'Healthy Snacks', category_id: snacks.id },
  { name: 'Dips & Spreads', category_id: snacks.id },
  { name: 'Party Snacks', category_id: snacks.id },
  { name: 'Sweet Snacks', category_id: snacks.id },
  { name: 'Savory Snacks', category_id: snacks.id }
])

# Main Dishes
main_dishes = Category.create!(name: 'Main Dishes')
Subcategory.create!([
  { name: 'Beef', category_id: main_dishes.id },
  { name: 'Poultry', category_id: main_dishes.id },
  { name: 'Pork', category_id: main_dishes.id },
  { name: 'Seafood', category_id: main_dishes.id },
  { name: 'Vegetarian', category_id: main_dishes.id }
])

# Side Dishes
side_dishes = Category.create!(name: 'Side Dishes')
Subcategory.create!([
  { name: 'Vegetables', category_id: side_dishes.id },
  { name: 'Potatoes', category_id: side_dishes.id },
  { name: 'Rice', category_id: side_dishes.id },
  { name: 'Pasta', category_id: side_dishes.id }
])

# Breakfast
breakfast = Category.create!(name: 'Breakfast')
Subcategory.create!([
  { name: 'Eggs', category_id: breakfast.id },
  { name: 'Pancakes & Waffles', category_id: breakfast.id },
  { name: 'Breakfast Meats', category_id: breakfast.id },
  { name: 'Cereals', category_id: breakfast.id }
])

# Soups & Salads
soups_salads = Category.create!(name: 'Soups & Salads')
Subcategory.create!([
  { name: 'Vegetable Soups', category_id: soups_salads.id },
  { name: 'Meat Soups', category_id: soups_salads.id },
  { name: 'Green Salads', category_id: soups_salads.id },
  { name: 'Pasta Salads', category_id: soups_salads.id }
])

# Salsas
salsas = Category.create!(name: 'Salsas')
Subcategory.create!([
  { name: 'Fresh Salsas', category_id: salsas.id },
  { name: 'Cooked Salsas', category_id: salsas.id },
  { name: 'Creamy Salsas', category_id: salsas.id },
  { name: 'Hot Salsas', category_id: salsas.id }
])

puts "Created #{Category.count} categories and #{Subcategory.count} subcategories"

# Update the category and subcategory variables for the rest of the seed file
category = Category.first
subcategory = Subcategory.first


# Seed UOMs
Uom.create([
  { name: 'gram', base_unit: 'gram', system: 'metric' },
  { name: 'kilogram', base_unit: 'gram', system: 'metric' },
  { name: 'milligram', base_unit: 'gram', system: 'metric' },
  { name: 'microgram', base_unit: 'gram', system: 'metric' },
  { name: 'liter', base_unit: 'liter', system: 'metric' },
  { name: 'milliliter', base_unit: 'liter', system: 'metric' },
  { name: 'cup', base_unit: 'cup', system: 'imperial' },
  { name: 'ounce', base_unit: 'ounce', system: 'imperial' },
  { name: 'pound', base_unit: 'ounce', system: 'imperial' },
  { name: 'teaspoon', base_unit: 'teaspoon', system: 'imperial' },
  { name: 'tablespoon', base_unit: 'teaspoon', system: 'imperial' },
  { name: 'piece', base_unit: 'piece', system: 'none'}
])

kg = Uom.find_by(name: 'kilogram')

9.times do |i|
  p "Recipe #{i + 1}"
  # rec = Recipe.new(title: "Recipe #{i + 1}", servings: 1, total_time: 60, author: 'EG', user_id: 1, cookbook_id: 1)
  # rec.category_id = category.id
  # rec.subcategory_id = subcategory.id

  # section = Section.new(name: 'Rub', recipe_id: rec.id, sort_number: 1)
  # section.save
  # rec.sections << section

  # p "Valid? #{rec.valid?}"
  # p rec.errors.full_messages
  # rec.save

  # step = Step.new(description: 'Oil the meat', step_number: 1, section_id: section.id)
  # step2 = Step.new(description: 'Rub the meat', step_number: 2, section_id: section.id)
  # section.steps << step
  # section.steps << step2

  # p "KG: #{kg.id}"
  # p "section: #{section.id}"

  # section.recipe_ingredients << RecipeIngredient.new(ingredient_id: meat.id, quantity: 1, uom_id: kg.id, section_id: section.id)
  # section.recipe_ingredients << RecipeIngredient.new(ingredient_id: oil.id,  quantity: 1, uom_id: kg.id, section_id: section.id)
  # section.recipe_ingredients << RecipeIngredient.new(ingredient_id: paprika.id,  quantity: 1, uom_id: kg.id, section_id: section.id)

  # p "Valid? #{section.valid?}"
  # p section.errors.full_messages
  # section.save
end

# Import Ingredients from CSV
require 'csv'

puts "Starting ingredient import..."
csv_file = Rails.root.join('db', 'ingredients-with-possible-units.csv')
if File.exist?(csv_file)
  puts "Importing ingredients from #{csv_file}..."
  
  # Read CSV with semi-colon separator
  CSV.foreach(csv_file, col_sep: ';', skip_blanks: true) do |row|
    next if row[0].blank?
    
    name = row[0]
    possible_units = row[2]
    
    # Update or create ingredient
    # We use find_or_initialize_by to avoid duplicates and update existing records
    ingredient = Ingredient.find_or_initialize_by(name: name)
    ingredient.suggested_uoms = possible_units
    ingredient.save!
  end
  puts "Imported ingredients. Total count: #{Ingredient.count}"
else
  puts "CSV file not found: #{csv_file}"
end

