# frozen_string_literal: true

class CreateSections < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  def up
    create_table :sections do |t|
      t.string :name, limit: 100, null: false
      t.integer :sort_number
      t.integer :recipe_id, null: false

      t.timestamps
    end
  end

  def down
    drop_table :sections
  end
end
