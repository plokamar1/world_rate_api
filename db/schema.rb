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

ActiveRecord::Schema[8.0].define(version: 2025_08_19_120447) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.float "rating", default: 0.0, null: false
    t.boolean "calculated", default: true, null: false
    t.integer "reviews_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "country_id"
    t.bigint "user_id"
    t.text "description"
    t.integer "food_rating", limit: 2, default: 0
    t.integer "nightlife_rating", limit: 2, default: 0
    t.integer "culture_rating", limit: 2, default: 0
    t.integer "transportation_rating", limit: 2, default: 0
    t.integer "expenses_rating", limit: 2, default: 0
    t.float "total_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id", "user_id"], name: "index_reviews_on_country_id_and_user_id", unique: true
    t.index ["country_id"], name: "index_reviews_on_country_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.integer "reviews_count", default: 0, null: false
    t.bigint "nationality_id"
    t.bigint "residence_country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nationality_id"], name: "index_users_on_nationality_id"
    t.index ["residence_country_id"], name: "index_users_on_residence_country_id"
  end

  add_foreign_key "reviews", "countries"
  add_foreign_key "reviews", "users"
  add_foreign_key "users", "countries", column: "nationality_id"
  add_foreign_key "users", "countries", column: "residence_country_id"
end
