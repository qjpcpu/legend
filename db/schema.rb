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

ActiveRecord::Schema.define(version: 20130729082652) do

  create_table "crumbs", force: true do |t|
    t.string   "caption"
    t.text     "description"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "crumbs", ["event_id"], name: "index_crumbs_on_event_id"

  create_table "events", force: true do |t|
    t.integer  "crumb_id"
    t.date     "start_date"
    t.integer  "duration",    default: 1
    t.string   "caption"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "available",   default: true
    t.integer  "story_id"
  end

  add_index "events", ["crumb_id"], name: "index_events_on_crumb_id"
  add_index "events", ["story_id"], name: "index_events_on_story_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "messages", force: true do |t|
    t.integer  "from"
    t.integer  "to"
    t.integer  "kind"
    t.integer  "priority",   default: 5
    t.text     "content"
    t.boolean  "handled",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["from"], name: "index_messages_on_from"
  add_index "messages", ["to"], name: "index_messages_on_to"

  create_table "stories", force: true do |t|
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "title"
    t.text     "instruction"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "story_infos", force: true do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "story_infos", ["story_id"], name: "index_story_infos_on_story_id"
  add_index "story_infos", ["user_id"], name: "index_story_infos_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
