class CreateTags < ActiveRecord::Migration[6.1]
  def up
    create_table :tags do |t|
      t.string :name, limit: 100, null: false
      t.string :color, limit: 20, null: false, default: '#FFFFFF'

      t.timestamps
    end
  end

  def down
    drop_table :tags
  end
end
