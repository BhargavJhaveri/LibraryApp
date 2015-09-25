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

ActiveRecord::Schema.define(version: 20150925011957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "library_admins", force: true do |t|
    t.string   "first_name",      limit: 25
    t.string   "Last_name",       limit: 50
    t.string   "email",                      default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",        limit: 25
    t.string   "password_digest", limit: 40
  end

  add_index "library_admins", ["username"], name: "index_library_admins_on_username", using: :btree

  create_table "library_books", force: true do |t|
    t.string   "ISBN",               limit: 50
    t.string   "TITLE",                         default: "", null: false
    t.string   "DESCRIPTION",        limit: 40
    t.string   "AUTHORS",            limit: 40
    t.string   "STATUS",             limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "library_members_id"
  end

  add_index "library_books", ["library_members_id"], name: "index_library_books_on_library_members_id", using: :btree

  create_table "library_members", force: true do |t|
    t.string   "first_name",      limit: 25
    t.string   "Last_name",       limit: 50
    t.string   "email",                      default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest", limit: 40
  end

  create_table "relationships", force: true do |t|
    t.string   "ISBN"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "Status",     limit: 10
  end

end
