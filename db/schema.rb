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

ActiveRecord::Schema.define(version: 20160707030518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "planets", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "slug"
    t.boolean  "active",     default: true
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "space_id"
    t.integer  "order_id"
    t.decimal  "total"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "active",     default: true
  end

  add_index "reservations", ["order_id"], name: "index_reservations_on_order_id", using: :btree
  add_index "reservations", ["space_id"], name: "index_reservations_on_space_id", using: :btree

  create_table "spaces", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "style_id"
    t.integer  "planet_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "approved",               default: false
    t.string   "image_url_file_name"
    t.string   "image_url_content_type"
    t.integer  "image_url_file_size"
    t.datetime "image_url_updated_at"
    t.string   "description"
    t.string   "slug"
    t.integer  "occupancy"
    t.boolean  "active",                 default: true
  end

  add_index "spaces", ["planet_id"], name: "index_spaces_on_planet_id", using: :btree
  add_index "spaces", ["style_id"], name: "index_spaces_on_style_id", using: :btree

  create_table "spaces_users", id: false, force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "space_id", null: false
  end

  create_table "styles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "slug"
    t.boolean  "active",     default: true
  end

  create_table "users", force: :cascade do |t|
    t.string  "username"
    t.string  "password_digest"
    t.integer "role"
    t.string  "password_confirmation"
    t.string  "screen_name"
    t.string  "uid"
    t.string  "oauth_token"
    t.string  "oauth_token_secret"
    t.string  "email"
    t.string  "phone_number"
    t.string  "first_name"
    t.string  "last_name"
    t.boolean "active",                default: true
  end

  add_foreign_key "orders", "users"
  add_foreign_key "reservations", "orders"
  add_foreign_key "reservations", "spaces"
  add_foreign_key "spaces", "planets"
  add_foreign_key "spaces", "styles"
end
