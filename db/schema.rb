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

ActiveRecord::Schema[8.0].define(version: 0) do
  create_table "app_actions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "app_module_actions", force: :cascade do |t|
    t.integer "AppModule_id", null: false
    t.integer "AppAction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["AppAction_id"], name: "index_app_module_actions_on_AppAction_id"
    t.index ["AppModule_id"], name: "index_app_module_actions_on_AppModule_id"
  end

  create_table "app_modules", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "app_permitions", force: :cascade do |t|
    t.integer "AppModuleAction_id", null: false
    t.integer "Profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["AppModuleAction_id"], name: "index_app_permitions_on_AppModuleAction_id"
    t.index ["Profile_id"], name: "index_app_permitions_on_Profile_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "status"
    t.integer "parent_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
  end

  create_table "product_configurations", force: :cascade do |t|
    t.string "field"
    t.boolean "active"
    t.boolean "mandatory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.decimal "cost_price", precision: 5, scale: 2
    t.string "mesure_unit"
    t.string "brand"
    t.text "description"
    t.string "status"
    t.decimal "weight"
    t.string "dimension"
    t.string "location_in_stock"
    t.decimal "taxes"
    t.string "keyword"
    t.text "observation"
    t.boolean "promotion"
    t.decimal "discount"
    t.string "product_type"
    t.integer "output"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spents", force: :cascade do |t|
    t.text "motive"
    t.decimal "amount", precision: 5, scale: 2
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_spents_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "profile_id", null: false
    t.boolean "active"
    t.index ["profile_id"], name: "index_users_on_profile_id"
  end
end
