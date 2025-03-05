class RemoveCreatedByRecipe < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipes, :created_by
  end
end
