class CreateUoms < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  def up
    create_table :uoms do |t|
      t.string :name, limit: 100, null: false
      t.string :base_unit, limit: 100, null: false
      t.string :system, limit: 10, null: false
      t.float :conversion

      t.timestamps
    end
  end

  def down
    drop_table :uoms
  end
end
