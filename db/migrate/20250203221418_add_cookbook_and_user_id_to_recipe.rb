class AddCookbookAndUserIdToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :cookbook_id, :integer
    add_column :recipes, :user_id, :integer
  end
end
