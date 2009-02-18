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

ActiveRecord::Schema.define(:version => 20090216101129) do

  create_table "announcements", :force => true do |t|
    t.date     "eventDate"
    t.string   "event"
    t.string   "memoDetail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendances", :force => true do |t|
    t.integer  "idNo"
    t.integer  "code"
    t.string   "courseNo"
    t.string   "absences"
    t.string   "attendanceStatus"
    t.date     "asOfDate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "class_schedules", :force => true do |t|
    t.integer  "idNo"
    t.integer  "code"
    t.string   "courseNo"
    t.string   "descriptiveTitle"
    t.integer  "units"
    t.string     "time"
    t.string   "day"
    t.string   "room"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_offerings", :force => true do |t|
    t.integer  "semester"
    t.integer  "endSchYr"
    t.string   "college"
    t.integer  "code"
    t.string   "courseNo"
    t.string   "descriptiveTitle"
    t.string   "time"
    t.string   "day"
    t.string   "room"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", :force => true do |t|
    t.integer  "idNo"
    t.integer  "semester"
    t.integer  "endSchYr"
    t.string   "courseNo"
    t.string   "descriptiveTitle"
    t.integer  "units"
    t.integer  "grade"
    t.string   "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guidances", :force => true do |t|
    t.integer  "idNo"
    t.time     "time"
    t.string   "day"
    t.text     "room"
    t.text     "guidanceStatus"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mobile_numbers", :force => true do |t|
    t.integer "idNo"
    t.string  "mobileNumber"
  end

  create_table "payment_schedules", :force => true do |t|
    t.integer  "idNo"
    t.date     "dateOfPayment"
    t.float    "amt"
    t.string   "textDetail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "idNo"
    t.string   "familyName"
    t.string   "givenName"
    t.string   "middleName"
    t.string   "gender"
    t.string   "course"
    t.integer  "yearLevel"
    t.string   "college"
    t.string   "address"
    t.string   "email"
    t.string   "mobileNumber"
    t.string   "fatherName"
    t.string   "motherName"
    t.string   "guardianName"
    t.string   "relationshipToGuardian"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "idno"
    t.string   "name"
    t.string   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tests", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tfassessments", :force => true do |t|
    t.integer  "idNo"
    t.string   "gradingTerm"
    t.float    "payAmt"
    t.date     "balanceAsOf"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tfbreakdowns", :force => true do |t|
    t.integer  "idNo"
    t.string   "item"
    t.float    "feeAmt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "violations", :force => true do |t|
    t.integer  "idNo"
    t.date     "dateOfViolation"
    t.string   "offense"
    t.string   "memoDetail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
