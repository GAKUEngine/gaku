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

ActiveRecord::Schema.define(:version => 20120204103734) do

  create_table "course_enrollments", :force => true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_enrollments", ["course_id"], :name => "index_course_enrollments_on_course_id"
  add_index "course_enrollments", ["student_id"], :name => "index_course_enrollments_on_student_id"

  create_table "courses", :force => true do |t|
    t.string   "code"
    t.integer  "syllabus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["syllabus_id"], :name => "index_courses_on_syllabus_id"

  create_table "schedules", :force => true do |t|
    t.datetime "start"
    t.datetime "end"
    t.string   "repeat"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "phone"
    t.string   "email"
    t.date     "birth"
    t.date     "admitted"
    t.date     "graduated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "syllabuses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "credits"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "teachers", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "phone"
    t.string   "email"
    t.date     "birth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
