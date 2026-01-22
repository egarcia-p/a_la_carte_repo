class AddShortNameToIngredients < ActiveRecord::Migration[8.0]
  def change
    add_column :ingredients, :short_name, :string
  end
end
