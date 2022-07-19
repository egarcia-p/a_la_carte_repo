# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  def up
    create_table :recipes do |t|
      t.string :title, limit: 255, null: false
      t.string :subtitle, limit: 255
      t.integer :servings, null: false
      t.integer :total_time, null: false
      t.string :author, limit: 255, null: false
      t.integer :category_id, null: false
      t.integer :subcategory_id, null: false

      t.timestamps
    end
  end

  def down
    drop_table :recipes
  end
end
