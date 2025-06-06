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

ActiveRecord::Schema[7.1].define(version: 2025_06_06_124921) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hero_classes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quest_categories", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category_xp", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "hero_class_id", null: false
    t.index ["hero_class_id"], name: "index_quest_categories_on_hero_class_id"
  end

  create_table "quests", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "xp_granted", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "frequency"
    t.boolean "user_created", default: false
    t.bigint "quest_category_id"
    t.index ["quest_category_id"], name: "index_quests_on_quest_category_id"
  end

  create_table "user_classes", force: :cascade do |t|
    t.integer "xp", default: 0, null: false
    t.integer "level", default: 1, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "hero_class_id"
    t.index ["hero_class_id"], name: "index_user_classes_on_hero_class_id"
    t.index ["user_id"], name: "index_user_classes_on_user_id"
  end

  create_table "user_quests", force: :cascade do |t|
    t.bigint "quest_id", null: false
    t.bigint "user_id", null: false
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "completed_frequency", default: 0
    t.integer "position"
    t.index ["quest_id"], name: "index_user_quests_on_quest_id"
    t.index ["user_id"], name: "index_user_quests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.date "date_birth"
    t.string "address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "quest_categories", "hero_classes"
  add_foreign_key "quests", "quest_categories"
  add_foreign_key "user_classes", "hero_classes", on_delete: :cascade
  add_foreign_key "user_classes", "users"
  add_foreign_key "user_quests", "quests"
  add_foreign_key "user_quests", "users"
end
