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

ActiveRecord::Schema.define(:version => 20130617100626) do

  create_table "bases", :force => true do |t|
    t.integer  "absorbancy"
    t.integer  "greenroof_id"
    t.text     "note"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "bases", ["greenroof_id"], :name => "index_bases_on_greenroof_id"

  create_table "colours", :force => true do |t|
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "colours", ["value"], :name => "index_colours_on_value"

  create_table "consists", :force => true do |t|
    t.integer  "base_id"
    t.integer  "layer_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "consists", ["base_id"], :name => "index_consists_on_base_id"
  add_index "consists", ["layer_id"], :name => "index_consists_on_layer_id"

  create_table "contacts", :force => true do |t|
    t.string   "otsikko"
    t.string   "osoite"
    t.string   "email"
    t.string   "puhelin"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "custom_plants", :force => true do |t|
    t.string   "name"
    t.integer  "greenroof_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "custom_plants", ["greenroof_id"], :name => "index_custom_plants_on_greenroof_id"

  create_table "environments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "flower_colours", :force => true do |t|
    t.integer  "colour_id"
    t.integer  "plant_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "flower_colours", ["colour_id"], :name => "index_flower_colours_on_colour_id"
  add_index "flower_colours", ["plant_id"], :name => "index_flower_colours_on_plant_id"

  create_table "greenroofs", :force => true do |t|
    t.string   "address"
    t.string   "locality"
    t.string   "constructor"
    t.integer  "year"
    t.text     "note"
    t.integer  "user_id"
    t.string   "status"
    t.text     "usage_experience"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "greenroofs", ["user_id"], :name => "index_greenroofs_on_user_id"

  create_table "growth_environments", :force => true do |t|
    t.string   "environment"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "growths", :force => true do |t|
    t.integer  "plant_id"
    t.integer  "growth_environment_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "growths", ["growth_environment_id"], :name => "index_growths_on_growth_environment_id"
  add_index "growths", ["plant_id"], :name => "index_growths_on_plant_id"

  create_table "images", :force => true do |t|
    t.string   "photo"
    t.string   "thumb"
    t.integer  "greenroof_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "layers", :force => true do |t|
    t.string   "name"
    t.string   "product_name"
    t.integer  "thickness"
    t.integer  "weight"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "lights", :force => true do |t|
    t.string   "value"
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

  create_table "maintenances", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "planteds", :force => true do |t|
    t.integer  "greenroof_id"
    t.integer  "plant_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "planteds", ["greenroof_id"], :name => "index_planteds_on_greenroof_id"
  add_index "planteds", ["plant_id"], :name => "index_planteds_on_plant_id"

  create_table "plants", :force => true do |t|
    t.string   "name"
    t.string   "latin_name"
    t.integer  "min_soil_thickness"
    t.integer  "weight"
    t.integer  "max_height"
    t.integer  "min_height"
    t.integer  "light_id"
    t.integer  "maintenance_id"
    t.string   "note"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "plants", ["name"], :name => "index_plants_on_name", :unique => true

  create_table "purposes", :force => true do |t|
    t.string   "value"
    t.integer  "greenroof_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "purposes", ["greenroof_id"], :name => "index_purposes_on_greenroof_id"

  create_table "roofs", :force => true do |t|
    t.integer  "declination"
    t.integer  "load_capacity"
    t.integer  "area"
    t.integer  "light_id"
    t.integer  "greenroof_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roofs", ["declination", "load_capacity", "area"], :name => "roof_index"
  add_index "roofs", ["greenroof_id"], :name => "index_roofs_on_greenroof_id"

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
