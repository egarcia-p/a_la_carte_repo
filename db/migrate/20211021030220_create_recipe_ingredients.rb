class CreateRecipeIngredients < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  def up
    create_table :recipe_ingredients do |t|
      t.integer :recipe_id, null: false
      t.integer :ingredient_id, null: false
      t.float :quantity, null: false
      t.integer :uom_id, null: false
      t.integer :section_id, null: false

      t.timestamps
    end
  end

  def down
    drop_table :recipe_ingredients
  end
end
