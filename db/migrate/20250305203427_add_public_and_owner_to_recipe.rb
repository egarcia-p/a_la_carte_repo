class AddPublicAndOwnerToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :is_public, :boolean, default: false
    add_column :recipes, :created_by, :string, null: false
  end
end
