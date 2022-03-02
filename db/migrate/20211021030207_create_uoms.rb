class CreateUoms < ActiveRecord::Migration[6.1]
  def up
    create_table :uoms do |t|
      t.string :name, :limit => 100, :null => false
      t.string :base_unit, :limit => 100, :null => false
      t.string :type, :limit => 10, :null => false
      t.float :conversion

      t.timestamps
    end
  end

  def down
    drop_table :uoms
  end
end
