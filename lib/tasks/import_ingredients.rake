namespace :import do
  desc "Import ingredients from CSV"
  task ingredients: :environment do
    require 'csv'

    file_path = Rails.root.join('tmp', 'ingredients-with-possible-units.csv')

    unless File.exist?(file_path)
      puts "File not found: #{file_path}"
      exit
    end

    puts "Starting import from #{file_path}..."
    count = 0

    # Assuming semicolon delimiter and no headers based on inspection
    CSV.foreach(file_path, col_sep: ';', headers: false) do |row|
      name = row[0]
      # row[1] is fdc_id, skipping
      suggested_uoms = row[2]

      next if name.blank?

      ingredient = Ingredient.find_or_create_by_name(name)
      ingredient.update(suggested_uoms: suggested_uoms)
      
      count += 1
      print "." if count % 100 == 0
    end

    puts "\nImport complete! Processed #{count} ingredients."
  end
end
