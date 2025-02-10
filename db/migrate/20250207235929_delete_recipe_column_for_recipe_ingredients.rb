class DeleteRecipeColumnForRecipeIngredients < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipe_ingredients, :recipe_id
  end
end
