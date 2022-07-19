class AddShortNameToUoms < ActiveRecord::Migration[6.1]
  def change
    add_column :uoms, :short_name, :string, limit: 10
  end
end
