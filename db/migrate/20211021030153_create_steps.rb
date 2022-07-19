# frozen_string_literal: true

class CreateSteps < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  def up
    create_table :steps do |t|
      t.text :description, null: false
      t.integer :step_number, null: false
      t.integer :section_id, null: false
      t.integer :recipe_id, null: false

      t.timestamps
    end
  end

  def down
    drop_table :steps
  end
end
