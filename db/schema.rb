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

ActiveRecord::Schema[8.1].define(version: 2025_11_25_000003) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "body_goals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "goal_date", null: false
    t.string "measurement_type", null: false
    t.string "metric_name", null: false
    t.text "note"
    t.decimal "target_value", precision: 10, scale: 2, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "metric_name"], name: "index_body_goals_on_user_id_and_metric_name"
    t.index ["user_id"], name: "index_body_goals_on_user_id"
  end

  create_table "body_snapshot_entries", force: :cascade do |t|
    t.bigint "body_snapshot_id", null: false
    t.datetime "created_at", null: false
    t.string "measurement_type", null: false
    t.string "metric_name", null: false
    t.datetime "updated_at", null: false
    t.decimal "value", precision: 10, scale: 2, null: false
    t.index ["body_snapshot_id", "metric_name"], name: "idx_on_body_snapshot_id_metric_name_1387afd6e3"
    t.index ["body_snapshot_id"], name: "index_body_snapshot_entries_on_body_snapshot_id"
  end

  create_table "body_snapshots", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "recorded_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "recorded_at"], name: "index_body_snapshots_on_user_id_and_recorded_at"
    t.index ["user_id"], name: "index_body_snapshots_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "otp_enabled", default: false, null: false
    t.datetime "otp_enabled_at"
    t.string "otp_secret"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "body_goals", "users"
  add_foreign_key "body_snapshot_entries", "body_snapshots"
  add_foreign_key "body_snapshots", "users"
end
