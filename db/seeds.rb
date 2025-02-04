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

meat = Ingredient.create(name: 'Meat')
oil = Ingredient.create(name: 'Oil')
paprika = Ingredient.create(name: 'Paprika')

kg = Uom.new(name: 'kg', base_unit: 'g', system: 'metric')
kg.save

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

  step = Step.new(description: 'Oil the meat', step_number: 1, section_id: section.id, recipe_id: rec.id)
  step2 = Step.new(description: 'Rub the meat', step_number: 2, section_id: section.id, recipe_id: rec.id)
  rec.steps << step
  rec.steps << step2

  p "KG: #{kg.id}"
  p "section: #{section.id}"

  rec.recipe_ingredients << RecipeIngredient.new(ingredient_id: meat.id, recipe_id: rec.id, quantity: 1, uom_id: kg.id, section_id: section.id)
  rec.recipe_ingredients << RecipeIngredient.new(ingredient_id: oil.id, recipe_id: rec.id, quantity: 1, uom_id: kg.id, section_id: section.id)
  rec.recipe_ingredients << RecipeIngredient.new(ingredient_id: paprika.id, recipe_id: rec.id, quantity: 1, uom_id: kg.id, section_id: section.id)

  p "Valid? #{rec.valid?}"
  p rec.errors.full_messages
  rec.save
end
