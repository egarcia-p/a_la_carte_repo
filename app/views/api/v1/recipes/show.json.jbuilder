# app/views/recipes/show.json.jbuilder

# json.content format_content(@recipe.content)
# json.(@message, :created_at, :updated_at)

json.call(@recipe, :author, :category_id, :created_at, :id, :servings, :subcategory_id, :subtitle, :title, :total_time,
          :updated_at)

json.sections @recipe.sections do |section| # rubocop:todo Metrics/BlockLength
  json.id section.id
  json.name section.name
  json.recipe_id section.recipe_id
  json.sort_number section.sort_number
  json.created_at section.created_at
  json.updated_at section.updated_at
  json.steps do
    json.array!(section.steps.sort_by { |o| o[:step_number] }) do |step|
      json.id step.id
      json.description step.description
      json.step_number step.step_number
      json.recipe_id step.recipe_id
      json.section_id step.section_id
    end
  end
  json.recipe_ingredients do
    json.array!(section.recipe_ingredients.sort_by { |o| o[:id] }) do |recipe_ingredient|
      json.id recipe_ingredient.id
      json.recipe_id recipe_ingredient.recipe_id
      json.ingredient_id recipe_ingredient.ingredient_id
      json.name recipe_ingredient.ingredient.name
      json.uom_id recipe_ingredient.uom_id
      json.uom_name recipe_ingredient.uom.name
      json.short_name recipe_ingredient.uom.short_name
      json.quantity recipe_ingredient.quantity
      json.section_id recipe_ingredient.section_id
      json.created_at recipe_ingredient.created_at
      json.updated_at recipe_ingredient.updated_at
    end
  end
  json.recipe_equipments section.recipe_equipments do |recipe_equipment|
    json.id recipe_equipment.id
    json.recipe_id recipe_equipment.recipe_id
    json.equipment_id recipe_equipment.equipment_id
    json.name recipe_equipment.equipment.name
    json.uom_id recipe_equipment.uom_id
    json.uom_name recipe_equipment.uom.name
    json.quantity recipe_equipment.quantity
    json.section_id recipe_equipment.section_id
    json.created_at recipe_equipment.created_at
    json.updated_at recipe_equipment.updated_at
  end
end

# if current_user.admin?
#   json.visitors calculate_visitors(@message)
# end

# json.comments @message.comments, :content, :created_at

# json.attachments @message.attachments do |attachment|
#   json.filename attachment.filename
#   json.url url_for(attachment)
# end
