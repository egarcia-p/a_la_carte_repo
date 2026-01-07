class UpdateIngredientsTable < ActiveRecord::Migration[8.0]
  def change
    remove_column :ingredients, :fdc_id, :integer
    remove_column :ingredients, :description, :text
    add_column :ingredients, :suggested_uoms, :string
  end
end
