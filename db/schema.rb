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

ActiveRecord::Schema.define(version: 20140915041917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sales", force: true do |t|
    t.string   "purchaser_name"
    t.string   "item_description"
    t.decimal  "item_price"
    t.integer  "purchase_count"
    t.string   "merchant_address"
    t.string   "merchant_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_name"
    t.integer  "user_id"
  end

  add_index "sales", ["user_id"], name: "index_sales_on_user_id", using: :btree

  create_table "sales_users", id: false, force: true do |t|
    t.integer "sale_id", null: false
    t.integer "user_id", null: false
  end

  add_index "sales_users", ["sale_id", "user_id"], name: "index_sales_users_on_sale_id_and_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sale_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["sale_id"], name: "index_users_on_sale_id", using: :btree

end
