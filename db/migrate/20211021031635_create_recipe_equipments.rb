class CreateRecipeEquipments < ActiveRecord::Migration[6.1]
  def up
    create_table :recipe_equipments do |t|
      t.integer :recipe_id, :null => false
      t.integer :equipment_id, :null => false
      t.float :quantity, :null => false
      t.integer :uom_id
      t.integer :section_id, :null => false

      t.timestamps
    end
  end

  def down
    drop_table :recipe_equipments
  end
end
