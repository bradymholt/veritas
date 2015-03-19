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

ActiveRecord::Schema.define(:version => 20150319025627) do

  create_table "attendances", :force => true do |t|
    t.integer  "contact_id"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "present"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "contact_queue_items", :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "contact_id"
    t.string   "reason"
    t.boolean  "is_completed"
    t.date     "completed_date"
    t.string   "completed_by"
    t.string   "completed_notes"
  end

  create_table "contacts", :force => true do |t|
    t.string   "last_name"
    t.string   "address"
    t.string   "city_state_zip"
    t.string   "home_phone"
    t.date     "anniversary"
    t.string   "first_name"
    t.string   "email"
    t.string   "phone"
    t.date     "birthday"
    t.string   "spouse_name"
    t.string   "spouse_email"
    t.string   "spouse_phone"
    t.date     "spouse_birthday"
    t.text     "notes"
    t.boolean  "is_member",       :default => false
    t.date     "member_date"
    t.boolean  "is_active",       :default => true
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "photo"
    t.boolean  "is_private",      :default => false
  end

  create_table "demos", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mobiles", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "phone_carrier_lookups", :force => true do |t|
    t.string   "phone_number"
    t.string   "carrier"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "phone_type"
  end

  create_table "podcasts", :force => true do |t|
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.date     "date"
    t.string   "title"
    t.string   "speaker"
    t.string   "audio"
    t.boolean  "is_facebook_posted", :default => false, :null => false
  end

  create_table "sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "settings", :force => true do |t|
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
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
    t.text     "visitor_email_html"
    t.string   "google_calendar_username"
    t.string   "google_calendar_password"
    t.string   "host_name"
    t.integer  "contact_queue_members_absent_weeks"
    t.string   "contact_queue_notify_email"
    t.integer  "contact_queue_visitors_present_weeks"
    t.string   "banner"
    t.string   "google_analytics_tracking_id"
    t.boolean  "contact_email_cc"
    t.integer  "contacts_inactivate_after_no_attendance_weeks"
    t.string   "podcast_itunes_url"
    t.text     "announcements_html"
    t.string   "facebook_access_token"
    t.string   "facebook_group_id"
    t.string   "carrier_lookup_api_key"
    t.text     "new_member_email_html"
    t.string   "google_calendar_refresh_token"
  end

  create_table "signup_slots", :force => true do |t|
    t.integer  "signup_id"
    t.date     "date"
    t.integer  "contact_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "notes"
    t.boolean  "reminder_sent"
  end

  create_table "signups", :force => true do |t|
    t.string   "title"
    t.string   "details"
    t.integer  "send_reminder_days"
    t.boolean  "visible_admin_only"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "tests", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
