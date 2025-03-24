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
Subcategory.create(name: 'SubCategory 1', category_id: 1)

category = Category.first
subcategory = Subcategory.first



meat = Ingredient.create(name: 'Meat')
oil = Ingredient.create(name: 'Oil')
paprika = Ingredient.create(name: 'Paprika')

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
  { name: 'tablespoon', base_unit: 'teaspoon', system: 'imperial' }
])

kg = Uom.find_by(name: 'kilogram')

9.times do |i|
  p "Recipe #{i + 1}"
  rec = Recipe.new(title: "Recipe #{i + 1}", servings: 1, total_time: 60, author: 'EG', user_id: 1, cookbook_id: 1)
  rec.category_id = category.id
  rec.subcategory_id = subcategory.id

  section = Section.new(name: 'Rub', recipe_id: rec.id, sort_number: 1)
  section.save
  rec.sections << section

  p "Valid? #{rec.valid?}"
  p rec.errors.full_messages
  rec.save

  step = Step.new(description: 'Oil the meat', step_number: 1, section_id: section.id)
  step2 = Step.new(description: 'Rub the meat', step_number: 2, section_id: section.id)
  section.steps << step
  section.steps << step2

  p "KG: #{kg.id}"
  p "section: #{section.id}"

  section.recipe_ingredients << RecipeIngredient.new(ingredient_id: meat.id, quantity: 1, uom_id: kg.id, section_id: section.id)
  section.recipe_ingredients << RecipeIngredient.new(ingredient_id: oil.id,  quantity: 1, uom_id: kg.id, section_id: section.id)
  section.recipe_ingredients << RecipeIngredient.new(ingredient_id: paprika.id,  quantity: 1, uom_id: kg.id, section_id: section.id)

  p "Valid? #{section.valid?}"
  p section.errors.full_messages
  section.save
end
