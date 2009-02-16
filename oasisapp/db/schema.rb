# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090216044630) do

  create_table "admins", :force => true do |t|
    t.string   "username",        :limit => 40, :null => false
    t.string   "hashed_password",               :null => false
    t.string   "salt",                          :null => false
    t.string   "last_name",                     :null => false
    t.string   "first_name",                    :null => false
    t.string   "position",        :limit => 2,  :null => false
    t.boolean  "active",                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "email"
    t.datetime "last_visit"
  end

  create_table "announcements", :force => true do |t|
    t.datetime "date_time",    :null => false
    t.text     "announcement", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "summary"
  end

  create_table "attendances", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "changes", :force => true do |t|
    t.text     "change_made", :null => false
    t.string   "ip_add"
    t.integer  "admin_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cur_onlines", :force => true do |t|
    t.datetime "date"
    t.string   "name"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "current_state_of_followers", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "guidance_rows"
    t.integer  "grade_rows"
    t.datetime "attendance_as_of"
    t.integer  "violation_rows"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tf_assessment_rows"
    t.integer  "tf_breakdown_rows"
  end

  create_table "followers", :force => true do |t|
    t.integer  "idno"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "grades", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "follower_id"
    t.string   "notification"
    t.text     "details"
    t.datetime "delivered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "idno"
  end

  create_table "profiles", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queries", :force => true do |t|
    t.string   "subject",                       :null => false
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "resolved",   :default => false
  end

  create_table "reports", :force => true do |t|
    t.date     "date"
    t.integer  "total"
    t.integer  "unique"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "last_login"
    t.datetime "cur_login"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_name"
    t.integer  "number_of_wards",                         :default => 0
    t.string   "status"
    t.string   "address"
    t.string   "cp_number"
    t.integer  "lang_pref"
    t.string   "nickname"
    t.boolean  "email_pref"
    t.boolean  "mobile_pref"
  end

  create_table "violations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
