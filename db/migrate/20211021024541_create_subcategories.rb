class CreateSubcategories < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  def up
    create_table :subcategories do |t|
      t.string :name, limit: 100, null: false
      t.integer :category_id, null: false

      t.timestamps
    end
  end

  def down
    drop_table :subcategories
  end
end
