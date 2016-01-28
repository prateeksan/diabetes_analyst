# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160128004344) do

  create_table "foods", force: :cascade do |t|
    t.float    "number"
    t.string   "name"
    t.string   "measure"
    t.float    "weight"
    t.float    "kcal"
    t.float    "kj"
    t.float    "protein"
    t.float    "carbohydrate"
    t.float    "total_sugar"
    t.float    "total_dietary_fibre"
    t.float    "total_fat"
    t.float    "calcium"
    t.float    "iron"
    t.float    "sodium"
    t.float    "potassium"
    t.float    "magnesium"
    t.float    "phosphorus"
    t.float    "vitamin_a"
    t.float    "beta_carotene"
    t.float    "lycopene"
    t.float    "folate"
    t.float    "vitamin_c"
    t.float    "vitamin_b12"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medications", force: :cascade do |t|
    t.string   "any"
    t.string   "din"
    t.string   "name"
    t.string   "form"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "email"
    t.date     "birth_date"
    t.date     "diagnosis_date"
    t.integer  "height"
    t.text     "medical_history"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
