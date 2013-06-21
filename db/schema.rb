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

ActiveRecord::Schema.define(:version => 20130621181211) do

  create_table "attendances", :force => true do |t|
    t.integer  "family_id"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "present"
  end

  create_table "contact_queue_items", :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "family_id"
    t.string   "reason"
    t.boolean  "is_completed"
    t.date     "completed_date"
    t.string   "completed_by"
    t.string   "completed_notes"
  end

  create_table "demos", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "families", :force => true do |t|
    t.string   "last_name"
    t.string   "address"
    t.string   "city_state_zip"
    t.string   "home_phone"
    t.date     "anniversary"
    t.string   "husband_name"
    t.string   "husband_email"
    t.string   "husband_phone"
    t.date     "husband_birthday"
    t.string   "wife_name"
    t.string   "wife_email"
    t.string   "wife_phone"
    t.date     "wife_birthday"
    t.text     "notes"
    t.boolean  "is_member"
    t.date     "member_date"
    t.boolean  "is_active"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "photo"
  end

  create_table "mobiles", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "podcasts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "date"
    t.string   "title"
    t.string   "speaker"
    t.string   "audio"
  end

  create_table "sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "settings", :force => true do |t|
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "group_name"
    t.string   "user_password"
    t.string   "admin_password"
    t.string   "logo"
    t.string   "contact_email"
    t.string   "app_icon"
    t.string   "group_description"
    t.string   "aws_bucket_name"
    t.string   "aws_access_key"
    t.string   "aws_secret_access_key"
    t.string   "smtp_server"
    t.string   "smtp_username"
    t.string   "smtp_password"
    t.integer  "smtp_port"
    t.boolean  "smtp_tls"
    t.text     "welcome_email_html",       :limit => 255
    t.string   "google_calendar_username"
    t.string   "google_calendar_password"
  end

end
