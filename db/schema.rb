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

ActiveRecord::Schema[7.0].define(version: 2024_06_24_154757) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

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
    t.integer "squat_first_attempt_result", default: 0, null: false
    t.integer "squat_second_attempt_result", default: 0, null: false
    t.integer "squat_third_attempt_result", default: 0, null: false
    t.integer "benchpress_first_attempt_result", default: 0, null: false
    t.integer "benchpress_second_attempt_result", default: 0, null: false
    t.integer "benchpress_third_attempt_result", default: 0, null: false
    t.integer "deadlift_first_attempt_result", default: 0, null: false
    t.integer "deadlift_second_attempt_result", default: 0, null: false
    t.integer "deadlift_third_attempt_result", default: 0, null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id"], name: "index_competition_records_on_competition_id", unique: true
  end

  create_table "competition_results", force: :cascade do |t|
    t.bigint "competition_record_id", null: false
    t.float "best_squat_weight"
    t.float "best_benchpress_weight"
    t.float "best_deadlift_weight"
    t.float "total_lifted_weight"
    t.float "ipf_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_record_id"], name: "index_competition_results_on_competition_record_id", unique: true
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

  create_table "profiles", force: :cascade do |t|
    t.integer "gender", null: false
    t.date "birthday", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "competition_records", "competitions"
  add_foreign_key "competition_results", "competition_records"
  add_foreign_key "competitions", "users"
  add_foreign_key "profiles", "users"
end
