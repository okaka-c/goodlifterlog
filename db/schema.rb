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

ActiveRecord::Schema[7.0].define(version: 2024_04_14_070228) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competition_records", force: :cascade do |t|
    t.bigint "competition_id", null: false
    t.float "weight", null: false
    t.float "squat_first_attempt"
    t.float "squat_second_attempt"
    t.float "squat_third_attempt"
    t.float "benchpress_first_attempt"
    t.float "benchpress_second_attempt"
    t.float "benchpress_third_attempt"
    t.float "deadlift_first_attempt"
    t.float "deadlift_second_attempt"
    t.float "deadlift_third_attempt"
    t.integer "squat_first_attempt_result", default: 0
    t.integer "squat_second_attempt_result", default: 0
    t.integer "squat_third_attempt_result", default: 0
    t.integer "benchpress_first_attempt_result", default: 0
    t.integer "benchpress_second_attempt_result", default: 0
    t.integer "benchpress_third_attempt_result", default: 0
    t.integer "deadlift_first_attempt_result", default: 0
    t.integer "deadlift_second_attempt_result", default: 0
    t.integer "deadlift_third_attempt_result", default: 0
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id"], name: "index_competition_records_on_competition_id", unique: true
  end

  create_table "competitions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "venue"
    t.date "date", null: false
    t.integer "competition_type", null: false
    t.integer "gearcategory_type", null: false
    t.string "category", null: false
    t.string "age_group", null: false
    t.string "weight_class", null: false
    t.integer "participation_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_competitions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "competition_records", "competitions"
  add_foreign_key "competitions", "users"
end
