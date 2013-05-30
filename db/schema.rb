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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130529071441) do

  create_table "bases", :force => true do |t|
    t.integer  "thickness"
    t.integer  "weight"
    t.string   "material"
    t.integer  "absorbancy"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "environments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "greenroofs", :force => true do |t|
    t.string   "address"
    t.integer  "purpose"
    t.string   "note"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "greenroofs", ["user_id"], :name => "index_greenroofs_on_user_id"

  create_table "lights", :force => true do |t|
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locations", :force => true do |t|
    t.integer  "roof_id"
    t.integer  "environment_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "locations", ["environment_id"], :name => "index_locations_on_environment_id"
  add_index "locations", ["roof_id"], :name => "index_locations_on_roof_id"

  create_table "plants", :force => true do |t|
    t.string   "name"
    t.string   "latin_name"
    t.string   "colour"
    t.integer  "aestethic_appeal"
    t.integer  "maintenance"
    t.integer  "min_soil_thickness"
    t.integer  "weight"
    t.integer  "coverage"
    t.integer  "light_id"
    t.string   "note"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "plants", ["name"], :name => "index_plants_on_name", :unique => true

  create_table "roofs", :force => true do |t|
    t.integer  "declination"
    t.integer  "load_capacity"
    t.integer  "area"
    t.integer  "light_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roofs", ["declination", "load_capacity", "area"], :name => "roof_index"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.string   "phone"
    t.string   "profession"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
