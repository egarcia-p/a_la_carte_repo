class CreateEquipment < ActiveRecord::Migration[6.1]
  def up
    create_table :equipment do |t|
      t.string :name, :limit => 255, :null => false
      t.string :material, :limit => 100

      t.timestamps
    end
  end

  def down
    drop_table :equipment
  end
end
