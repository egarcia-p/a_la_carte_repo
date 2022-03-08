# app/views/recipes/show.json.jbuilder

# json.content format_content(@recipe.content)
# json.(@message, :created_at, :updated_at)

json.call(@recipe, :author, :category_id, :created_at, :id, :servings, :subcategory_id, :subtitle, :title, :total_time,
          :updated_at)

json.sections @recipe.sections do |section|
  json.id section.id
  json.name section.name
  json.recipe_id section.recipe_id
  json.sort_number section.sort_number
  json.created_at section.created_at
  json.updated_at section.updated_at
  json.steps section.steps do |step|
    json.id step.id
    json.description step.description
    json.step_number step.step_number
    json.recipe_id step.recipe_id
    json.section_id step.section_id
    json.created_at section.created_at
    json.updated_at section.updated_at
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
