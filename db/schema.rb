# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160919123553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "name"
    t.string   "text"
    t.string   "category"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specialties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "group"
    t.integer  "course_year"
    t.integer  "specialty_id"
    t.index ["specialty_id"], name: "index_student_profiles_on_specialty_id", using: :btree
    t.index ["user_id"], name: "index_student_profiles_on_user_id", using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.integer  "course_year"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "specialty_id"
    t.integer  "teacher_profile_id"
    t.boolean  "special",            default: false
    t.index ["specialty_id"], name: "index_subjects_on_specialty_id", using: :btree
    t.index ["teacher_profile_id"], name: "index_subjects_on_teacher_profile_id", using: :btree
  end

  create_table "teacher_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teacher_profiles_on_user_id", using: :btree
  end

  create_table "teachers_schedules", force: :cascade do |t|
    t.date     "week"
    t.json     "schedule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "picture"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "roles_mask"
    t.boolean  "guest",                  default: false
    t.datetime "banned_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "workbooks", force: :cascade do |t|
    t.integer  "subject_id"
    t.string   "name"
    t.string   "description"
    t.string   "attachment"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "teacher_profile_id"
    t.index ["subject_id"], name: "index_workbooks_on_subject_id", using: :btree
    t.index ["teacher_profile_id"], name: "index_workbooks_on_teacher_profile_id", using: :btree
  end

  add_foreign_key "student_profiles", "specialties"
  add_foreign_key "student_profiles", "users"
  add_foreign_key "subjects", "specialties"
  add_foreign_key "subjects", "teacher_profiles"
  add_foreign_key "teacher_profiles", "users"
  add_foreign_key "workbooks", "subjects"
  add_foreign_key "workbooks", "teacher_profiles"
end
