# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2025_03_24_214117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cookbooks", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.integer "user_id", null: false
    t.boolean "is_favorite", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "equipment", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "material", limit: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "fdc_id"
    t.text "description"
  end

  create_table "recipe_equipments", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "equipment_id", null: false
    t.float "quantity", null: false
    t.integer "uom_id"
    t.integer "section_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer "ingredient_id", null: false
    t.float "quantity", null: false
    t.integer "uom_id", null: false
    t.integer "section_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "recipe_tags", id: false, force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.string "subtitle", limit: 255
    t.integer "servings", null: false
    t.integer "total_time", null: false
    t.string "author", limit: 255, null: false
    t.integer "category_id", null: false
    t.integer "subcategory_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "cookbook_id"
    t.integer "user_id"
    t.boolean "is_public", default: false
  end

  create_table "sections", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.integer "sort_number"
    t.integer "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "steps", force: :cascade do |t|
    t.text "description", null: false
    t.integer "step_number", null: false
    t.integer "section_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.integer "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "color", limit: 20, default: "#FFFFFF", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "uoms", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "base_unit", limit: 100, null: false
    t.string "system", limit: 10, null: false
    t.float "conversion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "short_name", limit: 10
  end

  create_table "users", force: :cascade do |t|
    t.string "sub", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
