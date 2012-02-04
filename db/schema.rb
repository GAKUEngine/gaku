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

ActiveRecord::Schema.define(:version => 20120202141053) do

  create_table "school_classes", :force => true do |t|
    t.string   "code"
    t.integer  "syllabus_id"
    t.integer  "schedule_id"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "school_classes", ["schedule_id"], :name => "index_school_classes_on_schedule_id"
  add_index "school_classes", ["syllabus_id"], :name => "index_school_classes_on_syllabus_id"
  add_index "school_classes", ["teacher_id"], :name => "index_school_classes_on_teacher_id"

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
  end

end
