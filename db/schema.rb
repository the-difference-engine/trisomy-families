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

ActiveRecord::Schema.define(version: 20170611180525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
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
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

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

  create_table "behavioral_healths", force: :cascade do |t|
    t.boolean  "add"
    t.boolean  "adhd"
    t.boolean  "bipolar"
    t.boolean  "autism_spectrum"
    t.boolean  "depression"
    t.boolean  "anxiety_disorder"
    t.boolean  "ocd"
    t.boolean  "schizophrenia"
    t.boolean  "addictions"
    t.boolean  "personality_disorder"
    t.boolean  "eating_disorder"
    t.boolean  "odd"
    t.boolean  "conduct_disorder"
    t.string   "other_diagnosis"
    t.boolean  "none"
    t.boolean  "learning_disability"
    t.boolean  "global_developmental_delay"
    t.boolean  "intellectual_disability"
    t.boolean  "speech_delay"
    t.boolean  "receptive_delay"
    t.boolean  "expressive_delay"
    t.boolean  "auditory_processing_disorder"
    t.boolean  "apraxia_dyspraxia"
    t.boolean  "visual_processing"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "other_delay"
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
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "user_id"
    t.boolean  "private",                     default: false
    t.string   "nickname"
    t.integer  "birth_order"
    t.string   "other_chrom_affected"
    t.integer  "mosaic_percentage"
    t.integer  "health_history_id"
    t.integer  "background_history_id"
    t.string   "primary_diagnosis"
    t.string   "secondary_diagnosis"
    t.string   "partial_trisomy"
    t.integer  "parent_id"
    t.string   "other_primary_diagnosis"
    t.string   "other_secondary_diagnosis"
    t.boolean  "registered",                  default: false
    t.boolean  "accepted"
    t.string   "address"
    t.integer  "family_id"
    t.integer  "contact_info_id"
    t.integer  "secondary_mosaic_percentage"
    t.string   "secondary_partial_trisomy"
  end

  create_table "congenital_heart_defects", force: :cascade do |t|
    t.boolean  "asd"
    t.boolean  "vsd"
    t.boolean  "pda"
    t.boolean  "av_canal_defect"
    t.boolean  "dorv"
    t.boolean  "tof"
    t.boolean  "pfo"
    t.string   "other"
    t.boolean  "not_applicable"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "contact_info_forms", force: :cascade do |t|
    t.string   "contact_first_name"
    t.string   "contact_last_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "parent_first_name"
    t.string   "parent_last_name"
    t.string   "parent_email"
    t.string   "parent_phone"
    t.string   "relationship"
    t.text     "other_info"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "child_id"
  end

  create_table "cranial_facials", force: :cascade do |t|
    t.boolean  "cranial_deformities"
    t.boolean  "cleft_palate"
    t.boolean  "cleft_lip"
    t.boolean  "high_arch"
    t.boolean  "low_set_ears"
    t.boolean  "wide_spaced_eyes"
    t.boolean  "wild_eyebrows"
    t.boolean  "extraordinarily_long_eyelashes"
    t.boolean  "overgrowth_of_gums"
    t.boolean  "delayed_teething"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "endocrines", force: :cascade do |t|
    t.boolean  "hyperthyroidism"
    t.boolean  "hypothyroidism"
    t.boolean  "early_onset_pubic_hair"
    t.boolean  "early_onset_puberty"
    t.boolean  "growth_hormone_deficiency"
    t.boolean  "calcium_deficiency"
    t.boolean  "high_cortisol"
    t.boolean  "diabetes"
    t.boolean  "hypoglycemia"
    t.boolean  "cushings_disease"
    t.boolean  "vitamin_d_deficiency"
    t.boolean  "anemia"
    t.boolean  "failure_to_thrive"
    t.boolean  "high_blood_pressure"
    t.boolean  "low_blood_pressure"
    t.boolean  "delayed_late_puberty"
    t.boolean  "unsure"
    t.string   "other"
    t.boolean  "high_blood_sugar"
    t.boolean  "unhealthy_cholesterol_levels"
    t.boolean  "increased_abdominal_fat"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
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

  create_table "families", force: :cascade do |t|
    t.string   "family_name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "story"
    t.string   "photo"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.string   "website"
  end

  create_table "gastric_surgeries", force: :cascade do |t|
    t.boolean  "repair_of_duodenal_atresia_stenosis_web"
    t.boolean  "repair_of_anal_stenosis_atresia"
    t.boolean  "gastrostomy_tube_placement"
    t.boolean  "surgery_for_hirschsprung_disease"
    t.boolean  "fundoplication_nissen_wrap"
    t.boolean  "none"
    t.string   "other"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
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
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "chd"
    t.integer  "chd_id"
    t.string   "offered_cardiac_surgery"
    t.integer  "first_cardiac_surgery_age"
    t.string   "first_cardiac_surgery_successful"
    t.boolean  "multiple_cardiac_surgeries"
    t.integer  "intestinal_issues_id"
    t.integer  "gastric_surgery_id"
    t.boolean  "seizure_epilepsy"
    t.integer  "nuerological_condition_id"
    t.integer  "muscular_skeletal_id"
    t.string   "sleep_apnea"
    t.integer  "cranial_facial_id"
    t.string   "cancer"
    t.integer  "endocrine_id"
    t.boolean  "metabolic_syndrome"
    t.string   "hearing_test"
    t.boolean  "had_an_abr"
    t.string   "hearing_loss_or_deaf"
    t.string   "hearing_loss_treatment"
    t.string   "failed_eye_exam"
    t.integer  "vision_id"
    t.integer  "behavioral_health_id"
    t.string   "in_ei"
    t.boolean  "attend_school"
    t.boolean  "home_schooled_bound"
    t.string   "highest_education"
    t.integer  "received_therapy_id"
    t.boolean  "clinical_trial"
    t.boolean  "clinical_trial_participation"
    t.integer  "hearing_id"
    t.string   "other_cancer"
  end

  create_table "hearings", force: :cascade do |t|
    t.boolean  "transient"
    t.boolean  "conductive"
    t.boolean  "nerve_loss"
    t.boolean  "unknown"
    t.string   "other"
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

  create_table "intestinal_issues", force: :cascade do |t|
    t.boolean  "duodenal_atresia_stenosis_web"
    t.boolean  "anal_stenosis_atresia"
    t.boolean  "esophageal_atresia"
    t.boolean  "hirschsprung_disease"
    t.boolean  "chronic_constipation"
    t.boolean  "dysphagia"
    t.boolean  "aspiration"
    t.boolean  "chronic_diarrhea"
    t.boolean  "pyloric_stenosis"
    t.boolean  "gastroesophageal_reflux"
    t.boolean  "pepticulcers_gallstones"
    t.boolean  "hemorrhoids"
    t.boolean  "diverticulitis_diverticulosis"
    t.boolean  "colorectal_carcinoma"
    t.boolean  "ibs"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "ibd"
  end

  create_table "mother_complications", force: :cascade do |t|
    t.boolean  "none"
    t.boolean  "gestational_diabetes"
    t.boolean  "preeclampsia"
    t.boolean  "clampsia"
    t.boolean  "rh_factor"
    t.boolean  "separated_placenta"
    t.boolean  "unsure"
    t.boolean  "extra_fluid"
    t.string   "other"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "muscular_skeletals", force: :cascade do |t|
    t.boolean  "atlanto_axial_instability"
    t.boolean  "cervical_spine_degeneration"
    t.boolean  "osteopenia"
    t.boolean  "osteoporosis"
    t.boolean  "fractures"
    t.boolean  "scoliosis"
    t.boolean  "lordosis"
    t.boolean  "kyphosis"
    t.boolean  "hand_bone_missing"
    t.boolean  "leg_bone_missing"
    t.boolean  "rib_deformities"
    t.boolean  "club_foot"
    t.boolean  "rocker_bottom_feet"
    t.boolean  "atlanto_axial_instability_surgery"
    t.boolean  "cervical_spine_degeneration_surgery"
    t.boolean  "osteopenia_surgery"
    t.boolean  "osteoporosis_surgery"
    t.boolean  "fractures_surgery"
    t.boolean  "scoliosis_surgery"
    t.boolean  "lordosis_surgery"
    t.boolean  "kyphosis_surgery"
    t.boolean  "hand_bone_missing_surgery"
    t.boolean  "leg_bone_missing_surgery"
    t.boolean  "rib_deformities_surgery"
    t.boolean  "club_foot_surgery"
    t.boolean  "rocker_bottom_feet_surgery"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "nuerological_conditions", force: :cascade do |t|
    t.boolean  "brain_malformation"
    t.boolean  "cyst"
    t.boolean  "cp"
    t.boolean  "stroke"
    t.boolean  "unsure"
    t.boolean  "brain_malformation_surgery"
    t.boolean  "cyst_surgery"
    t.boolean  "cp_surgery"
    t.boolean  "stroke_surgery"
    t.string   "other"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "seizure_epilepsy"
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
    t.integer  "child_id"
    t.string   "first_name_2"
    t.string   "last_name_2"
    t.string   "city_2"
    t.string   "state_2"
    t.string   "phone_number_2"
    t.string   "email_2"
    t.string   "relationship_2"
  end

  create_table "partial_trisomies", force: :cascade do |t|
    t.boolean  "p"
    t.boolean  "q"
    t.boolean  "both"
    t.boolean  "unsure"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "physicians", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "website"
    t.string   "specialty"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.decimal  "latitude",             precision: 13, scale: 10
    t.decimal  "longitude",            precision: 13, scale: 10
    t.string   "personal_number"
    t.boolean  "primary_phone_public"
    t.string   "avatar_file_name"
    t.integer  "user_id"
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

  create_table "privacies", force: :cascade do |t|
    t.integer  "child_id"
    t.boolean  "story"
    t.boolean  "avatar"
    t.boolean  "location"
    t.boolean  "birthday"
    t.boolean  "trisomy_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "received_therapies", force: :cascade do |t|
    t.boolean  "ot"
    t.boolean  "pt"
    t.boolean  "dt"
    t.boolean  "st"
    t.boolean  "dtv"
    t.boolean  "dth"
    t.boolean  "vital_stim"
    t.boolean  "aquatic"
    t.boolean  "reflex_integration"
    t.boolean  "hippotherapy_equine"
    t.boolean  "hyperbaric"
    t.string   "other"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
    t.string   "email",                                            default: "", null: false
    t.string   "encrypted_password",                               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
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
    t.string   "family_name"
    t.string   "address"
    t.string   "state"
    t.string   "city"
    t.string   "zip_code"
    t.decimal  "latitude",               precision: 13, scale: 10
    t.decimal  "longitude",              precision: 13, scale: 10
    t.string   "user_type"
    t.integer  "family_id"
    t.integer  "doctor_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "visions", force: :cascade do |t|
    t.boolean  "cataract"
    t.boolean  "strabismus"
    t.boolean  "lazy_eye"
    t.boolean  "near_sighted"
    t.boolean  "far_sighted"
    t.boolean  "cvi"
    t.boolean  "astigmatism"
    t.boolean  "ptosis"
    t.boolean  "blockage_of_tear_duct"
    t.boolean  "depth_perception_problems"
    t.boolean  "blindness"
    t.boolean  "glaucoma"
    t.boolean  "torn_retina"
    t.boolean  "detached_retina"
    t.boolean  "undeveloped_eyes"
    t.boolean  "underdeveloped_eyes"
    t.boolean  "undeveloped_eye_socket"
    t.boolean  "underdeveloped_eye_socket"
    t.boolean  "dry_eyes"
    t.boolean  "doesnt_blink_well"
    t.boolean  "doesnt_close_eyes_when_sleeping"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
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
