class CreateCookbooks < ActiveRecord::Migration[6.1]
  def change
    create_table :cookbooks do |t|
      t.string :name, limit: 100, null: false
      t.integer :user_id, null: false
      t.boolean :is_favorite, null: false, default: false

      t.timestamps
    end
  end
end
