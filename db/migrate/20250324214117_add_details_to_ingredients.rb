class AddDetailsToIngredients < ActiveRecord::Migration[6.1]
  def change
    add_column :ingredients, :fdc_id, :integer
    add_column :ingredients, :description, :text
  end
end
