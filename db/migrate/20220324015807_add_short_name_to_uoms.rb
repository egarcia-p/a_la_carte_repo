# frozen_string_literal: true

class AddShortNameToUoms < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  def change
    add_column :uoms, :short_name, :string, limit: 10
  end
end
