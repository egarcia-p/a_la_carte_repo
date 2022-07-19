class CreateRecipeTags < ActiveRecord::Migration[6.1]
  def up
    create_table :recipe_tags, id: false do |t|
      t.integer :recipe_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end

  def down
    drop_table :recipe_tags
  end
end
