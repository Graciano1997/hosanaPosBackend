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

ActiveRecord::Schema[8.0].define(version: 2025_02_15_193757) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "status"
    t.integer "parent_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "qty"
    t.decimal "price", precision: 5, scale: 2
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expire_date"
    t.date "manufacture_date"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  add_foreign_key "categories", "categories", column: "parent_category_id"
  add_foreign_key "products", "categories"
end
