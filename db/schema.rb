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

ActiveRecord::Schema.define(version: 20161027004737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "background_histories", force: :cascade do |t|
    t.decimal  "weight_at_birth"
    t.integer  "height_at_birth"
    t.integer  "head_circumference_at_birth"
    t.boolean  "trisomy_relative"
    t.string   "delivery_method"
    t.integer  "weight_id"
    t.integer  "height_id"
    t.integer  "head_circumference_id"
    t.integer  "mother_complication_id"
    t.string   "offered_c_section"
    t.string   "child_complication"
    t.string   "apgar_score"
    t.integer  "gestation_age"
    t.integer  "mother_age_at_birth"
    t.integer  "father_age_at_birth"
    t.boolean  "multiple_birth"
    t.boolean  "multiple_birth_trisomy"
    t.boolean  "siblings_with_trisomy"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "children", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "trisomy_type"
    t.datetime "birth_date"
    t.datetime "death_date"
    t.string   "city"
    t.string   "state"
    t.text     "trisomy_story"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "user_id"
    t.string   "nickname"
    t.integer  "birth_order"
    t.string   "other_chrom_affected"
    t.integer  "mosaic_percentage"
    t.integer  "primary_diagnosis_id"
    t.integer  "secondary_diagnosis_id"
    t.integer  "partial_trisomy_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "start"
    t.datetime "end"
    t.string   "event_type"
    t.boolean  "allDay"
    t.string   "location"
  end

  create_table "head_circumferences", force: :cascade do |t|
    t.decimal  "one_month"
    t.decimal  "two_month"
    t.decimal  "three_month"
    t.decimal  "four_month"
    t.decimal  "five_month"
    t.decimal  "six_month"
    t.decimal  "one_year"
    t.decimal  "eighteen_month"
    t.decimal  "two_year"
    t.decimal  "three_year"
    t.decimal  "four_year"
    t.decimal  "five_year"
    t.decimal  "six_year"
    t.decimal  "seven_year"
    t.decimal  "eight_year"
    t.decimal  "nine_year"
    t.decimal  "ten_year"
    t.decimal  "eleven_year"
    t.decimal  "twelve_year"
    t.decimal  "thirteen_year"
    t.decimal  "fourteen_year"
    t.decimal  "fifteen_year"
    t.decimal  "sixteen_year"
    t.decimal  "seventeen_year"
    t.decimal  "eighteen_year"
    t.decimal  "nineteen_year"
    t.decimal  "twenty_year"
    t.decimal  "twentyone_year"
    t.decimal  "twentytwo_year"
    t.decimal  "twentythree_year"
    t.decimal  "twentyfour_year"
    t.decimal  "twentyfive_year"
    t.decimal  "twentysix_year"
    t.decimal  "twentyseven_year"
    t.decimal  "twentyeight_year"
    t.decimal  "twentynine_year"
    t.decimal  "thirty_year"
    t.decimal  "thirtyone_year"
    t.decimal  "thirtytwo_year"
    t.decimal  "thirtythree_year"
    t.decimal  "thirtyfour_year"
    t.decimal  "thirtyfive_year"
    t.decimal  "thirtysix_year"
    t.decimal  "thirtyseven_year"
    t.decimal  "thirtyeight_year"
    t.decimal  "thirtynine_year"
    t.decimal  "forty_year"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "health_histories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "heights", force: :cascade do |t|
    t.decimal  "one_month"
    t.decimal  "two_month"
    t.decimal  "three_month"
    t.decimal  "four_month"
    t.decimal  "five_month"
    t.decimal  "six_month"
    t.decimal  "one_year"
    t.decimal  "eighteen_month"
    t.decimal  "two_year"
    t.decimal  "three_year"
    t.decimal  "four_year"
    t.decimal  "five_year"
    t.decimal  "six_year"
    t.decimal  "seven_year"
    t.decimal  "eight_year"
    t.decimal  "nine_year"
    t.decimal  "ten_year"
    t.decimal  "eleven_year"
    t.decimal  "twelve_year"
    t.decimal  "thirteen_year"
    t.decimal  "fourteen_year"
    t.decimal  "fifteen_year"
    t.decimal  "sixteen_year"
    t.decimal  "seventeen_year"
    t.decimal  "eighteen_year"
    t.decimal  "nineteen_year"
    t.decimal  "twenty_year"
    t.decimal  "twentyone_year"
    t.decimal  "twentytwo_year"
    t.decimal  "twentythree_year"
    t.decimal  "twentyfour_year"
    t.decimal  "twentyfive_year"
    t.decimal  "twentysix_year"
    t.decimal  "twentyseven_year"
    t.decimal  "twentyeight_year"
    t.decimal  "twentynine_year"
    t.decimal  "thirty_year"
    t.decimal  "thirtyone_year"
    t.decimal  "thirtytwo_year"
    t.decimal  "thirtythree_year"
    t.decimal  "thirtyfour_year"
    t.decimal  "thirtyfive_year"
    t.decimal  "thirtysix_year"
    t.decimal  "thirtyseven_year"
    t.decimal  "thirtyeight_year"
    t.decimal  "thirtynine_year"
    t.decimal  "forty_year"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "parents", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.string   "phone_number"
    t.string   "email"
    t.string   "relationship"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "partial_trisomies", force: :cascade do |t|
    t.boolean  "p"
    t.boolean  "q"
    t.boolean  "both"
    t.boolean  "unsure"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "primary_diagnoses", force: :cascade do |t|
    t.boolean  "full"
    t.boolean  "partial"
    t.boolean  "mosaic"
    t.boolean  "balanced_translocation"
    t.boolean  "unbalanced_translocation"
    t.boolean  "ring"
    t.string   "other"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "school_therapies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "secondary_diagnoses", force: :cascade do |t|
    t.boolean  "full"
    t.boolean  "partial"
    t.boolean  "mosaic"
    t.boolean  "balanced_translocation"
    t.boolean  "unbalanced_translocation"
    t.boolean  "ring"
    t.boolean  "deletion"
    t.string   "other"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "relationship"
    t.string   "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "weights", force: :cascade do |t|
    t.decimal  "one_month"
    t.decimal  "two_month"
    t.decimal  "three_month"
    t.decimal  "four_month"
    t.decimal  "five_month"
    t.decimal  "six_month"
    t.decimal  "one_year"
    t.decimal  "eighteen_month"
    t.decimal  "two_year"
    t.decimal  "three_year"
    t.decimal  "four_year"
    t.decimal  "five_year"
    t.decimal  "six_year"
    t.decimal  "seven_year"
    t.decimal  "eight_year"
    t.decimal  "nine_year"
    t.decimal  "ten_year"
    t.decimal  "eleven_year"
    t.decimal  "twelve_year"
    t.decimal  "thirteen_year"
    t.decimal  "fourteen_year"
    t.decimal  "fifteen_year"
    t.decimal  "sixteen_year"
    t.decimal  "seventeen_year"
    t.decimal  "eighteen_year"
    t.decimal  "nineteen_year"
    t.decimal  "twenty_year"
    t.decimal  "twentyone_year"
    t.decimal  "twentytwo_year"
    t.decimal  "twentythree_year"
    t.decimal  "twentyfour_year"
    t.decimal  "twentyfive_year"
    t.decimal  "twentysix_year"
    t.decimal  "twentyseven_year"
    t.decimal  "twentyeight_year"
    t.decimal  "twentynine_year"
    t.decimal  "thirty_year"
    t.decimal  "thirtyone_year"
    t.decimal  "thirtytwo_year"
    t.decimal  "thirtythree_year"
    t.decimal  "thirtyfour_year"
    t.decimal  "thirtyfive_year"
    t.decimal  "thirtysix_year"
    t.decimal  "thirtyseven_year"
    t.decimal  "thirtyeight_year"
    t.decimal  "thirtynine_year"
    t.decimal  "forty_year"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
