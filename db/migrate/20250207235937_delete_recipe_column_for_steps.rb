class DeleteRecipeColumnForSteps < ActiveRecord::Migration[6.1]
  def change
    remove_column :steps, :recipe_id
  end
end
