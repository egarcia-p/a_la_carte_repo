class CreateIngredients < ActiveRecord::Migration[6.1]
  def up
    create_table :ingredients do |t|
      t.string :name, :limit => 100, :null => false
      
      t.timestamps
    end
  end

  def down
    drop_table :ingredients
  end
end
