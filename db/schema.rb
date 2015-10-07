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

ActiveRecord::Schema.define(version: 20151007165545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "library_admins", force: true do |t|
    t.text     "first_name"
    t.text     "Last_name"
    t.text     "email",           default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "username"
    t.text     "password_digest"
  end

  add_index "library_admins", ["username"], name: "index_library_admins_on_username", using: :btree

  create_table "library_books", force: true do |t|
    t.text     "isbn"
    t.text     "title",             default: "", null: false
    t.text     "description"
    t.text     "authors"
    t.text     "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "library_member_id"
    t.integer  "library_admin_id"
  end

  add_index "library_books", ["library_admin_id"], name: "index_library_books_on_library_admin_id", using: :btree
  add_index "library_books", ["library_member_id"], name: "index_library_books_on_library_member_id", using: :btree

  create_table "library_members", force: true do |t|
    t.text     "first_name"
    t.text     "Last_name"
    t.text     "email",           default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "password_digest"
  end

  create_table "mailers", force: true do |t|
    t.text     "isbn"
    t.text     "email",      default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.text     "isbn"
    t.text     "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "status"
  end

  create_table "suggestions", force: true do |t|
    t.text     "isbn"
    t.text     "title",       default: "", null: false
    t.text     "description"
    t.text     "authors"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "email"
  end

end
