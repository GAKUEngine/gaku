class GakuCore < ActiveRecord::Migration
  def change

    create_table "gaku_achievements" do |t|
      t.string   "name"
      t.text     "description"
      t.string   "authority"
      t.string   "badge_file_name"
      t.string   "badge_content_type"
      t.integer  "badge_file_size"
      t.datetime "badge_updated_at"
      t.integer  "external_school_record_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_addresses" do |t|
      t.string   "address1"
      t.string   "address2"
      t.string   "city"
      t.string   "zipcode"
      t.string   "title"
      t.boolean  "deleted",       default: false
      t.boolean  "primary",       default: false
      t.integer  "addressable_id"
      t.string   "addressable_type"
      t.integer  "country_id"
      t.integer  "state_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_assignment_scores" do |t|
      t.float    "score"
      t.integer  "student_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_assignments" do |t|
      t.string   "name"
      t.text     "description"
      t.integer  "max_score"
      t.integer  "syllabus_id"
      t.integer  "grading_method_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_attachments" do |t|
      t.string   "name"
      t.text     "description"
      t.boolean  "deleted",         default: false
      t.integer  "attachable_id"
      t.string   "attachable_type"
      t.string   "asset_file_name"
      t.string   "asset_content_type"
      t.integer  "asset_file_size"
      t.datetime "asset_updated_at"
    end

    create_table "gaku_attendance_type_translations" do |t|
      t.integer  "gaku_attendance_type_id", null: false
      t.string   "locale",                  null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "name"
    end

    add_index "gaku_attendance_type_translations", ["gaku_attendance_type_id"], name: "index_144d49f40337496bacec02aefc694f93f07d0581", using: :btree
    add_index "gaku_attendance_type_translations", ["locale"], name: "index_gaku_attendance_type_translations_on_locale", using: :btree

    create_table "gaku_attendance_types" do |t|
      t.string   "name"
      t.string   "color_code"
      t.boolean  "counted_absent"
      t.boolean  "disable_credit"
      t.float    "credit_rate"
      t.boolean  "auto_credit"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_attendances" do |t|
      t.text     "reason"
      t.integer  "attendancable_id"
      t.string   "attendancable_type"
      t.integer  "student_id"
      t.integer  "attendance_type_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_campuses" do |t|
      t.string   "name"
      t.boolean  "master",            default: false
      t.integer  "school_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "picture_file_name"
      t.string   "picture_content_type"
      t.integer  "picture_file_size"
      t.datetime "picture_updated_at"
      t.integer  "contacts_count",       default: 0
      t.integer  "addresses_count",      default: 0
    end

    create_table "gaku_class_group_course_enrollments" do |t|
      t.integer  "class_group_id"
      t.integer  "course_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_class_group_enrollments" do |t|
      t.integer  "seat_number"
      t.integer  "class_group_id"
      t.integer  "student_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_class_groups" do |t|
      t.string   "name"
      t.integer  "grade"
      t.string   "homeroom"
      t.integer  "faculty_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "notes_count", default: 0
    end

    create_table "gaku_commute_method_type_translations" do |t|
      t.integer  "gaku_commute_method_type_id", null: false
      t.string   "locale",                      null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "name"
    end

    add_index "gaku_commute_method_type_translations", ["gaku_commute_method_type_id"], name: "index_27960af5d7e19e965cc26c8f98c7d21e3a0ce580", using: :btree
    add_index "gaku_commute_method_type_translations", ["locale"], name: "index_gaku_commute_method_type_translations_on_locale", using: :btree

    create_table "gaku_commute_method_types" do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_contact_types" do |t|
      t.string "name"
    end

    create_table "gaku_contacts" do |t|
      t.string   "data"
      t.text     "details"
      t.boolean  "primary",       default: false
      t.boolean  "emergency",     default: false
      t.boolean  "deleted",       default: false
      t.integer  "contactable_id"
      t.string   "contactable_type"
      t.integer  "contact_type_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_countries" do |t|
      t.string  "iso_name"
      t.string  "iso"
      t.string  "iso3"
      t.string  "name"
      t.integer "numcode"
    end

    create_table "gaku_course_enrollments" do |t|
      t.integer  "student_id"
      t.integer  "course_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_course_group_enrollments" do |t|
      t.integer "course_id"
      t.integer "course_group_id"
    end

    create_table "gaku_course_groups" do |t|
      t.string   "name"
      t.boolean  "deleted", default: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_courses" do |t|
      t.string   "name"
      t.string   "code"
      t.integer  "faculty_id"
      t.integer  "syllabus_id"
      t.integer  "class_group_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "notes_count",    default: 0
      t.integer  "students_count", default: 0
    end

    create_table "gaku_enrollment_status_translations" do |t|
      t.integer  "gaku_enrollment_status_id", null: false
      t.string   "locale",                    null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "name"
    end

    add_index "gaku_enrollment_status_translations", ["gaku_enrollment_status_id"], name: "index_7865fd45090cea7b7810b5288a698bba41d45b8e", using: :btree
    add_index "gaku_enrollment_status_translations", ["locale"], name: "index_gaku_enrollment_status_translations_on_locale", using: :btree

    create_table "gaku_enrollment_statuses" do |t|
      t.string   "code"
      t.string   "name"
      t.boolean  "active"
      t.boolean  "immutable"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_exam_portion_scores" do |t|
      t.float    "score"
      t.string   "entry_number"
      t.integer  "exam_portion_id"
      t.integer  "student_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_exam_portions" do |t|
      t.string   "name"
      t.float    "max_score"
      t.float    "weight"
      t.integer  "problem_count"
      t.text     "description"
      t.text     "adjustments"
      t.integer  "position"
      t.integer  "exam_id"
      t.integer  "grading_method_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_exam_schedules" do |t|
      t.integer "exam_portion_id"
      t.integer "schedule_id"
      t.integer "course_id"
    end

    create_table "gaku_exam_scores" do |t|
      t.float    "score"
      t.text     "comment"
      t.integer  "exam_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_exam_syllabuses" do |t|
      t.integer  "exam_id"
      t.integer  "syllabus_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_exams" do |t|
      t.string   "name"
      t.text     "description"
      t.text     "adjustments"
      t.float    "weight"
      t.boolean  "use_weighting",     default: false
      t.boolean  "standalone",     default: false
      t.boolean  "deleted",        default: false
      t.boolean  "has_entry_numbers", default: false
      t.integer  "grading_method_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "notes_count",       default: 0
    end

    create_table "gaku_external_school_records" do |t|
      t.date     "beginning"
      t.date     "ending"
      t.string   "student_id_number"
      t.integer  "absences"
      t.float    "attendance_rate"
      t.boolean  "graduated"
      t.text     "data"
      t.integer  "school_id"
      t.integer  "student_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_extracurricular_activities" do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_extracurricular_activity_enrollments" do |t|
      t.integer  "extracurricular_activity_id"
      t.integer  "student_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_faculties" do |t|
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_grading_method_set_items" do |t|
      t.integer  "grading_method_id"
      t.integer  "grading_method_set_id"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "gaku_grading_method_set_items", ["grading_method_id"], name: "index_gaku_grading_method_set_items_on_grading_method_id", using: :btree
    add_index "gaku_grading_method_set_items", ["grading_method_set_id"], name: "index_gaku_grading_method_set_items_on_grading_method_set_id", using: :btree

    create_table "gaku_grading_method_sets" do |t|
      t.string   "name"
      t.boolean  "primary",        default: false
      t.boolean  "display_deviation", default: true
      t.boolean  "display_rank",      default: true
      t.boolean  "rank_order",        default: true
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_grading_methods" do |t|
      t.string   "name"
      t.text     "description"
      t.text     "method"
      t.text     "arguments"
      t.boolean  "curved",      default: true
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_guardians" do |t|
      t.string   "name"
      t.string   "surname"
      t.string   "middle_name"
      t.string   "name_reading",         default: ""
      t.string   "middle_name_reading",  default: ""
      t.string   "surname_reading",      default: ""
      t.boolean  "gender"
      t.date     "birth_date"
      t.string   "relationship"
      t.boolean  "deleted",           default: false
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "picture_file_name"
      t.string   "picture_content_type"
      t.integer  "picture_file_size"
      t.datetime "picture_updated_at"
      t.integer  "addresses_count",      default: 0
      t.integer  "contacts_count",       default: 0
    end

    create_table "gaku_import_files" do |t|
      t.string   "context"
      t.string   "importer_type"
      t.string   "data_file_file_name"
      t.string   "data_file_content_type"
      t.integer  "data_file_file_size"
      t.datetime "data_file_updated_at"
    end

    create_table "gaku_installs" do |t|
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
    end

    add_index "gaku_installs", ["email"], name: "index_gaku_installs_on_email", unique: true, using: :btree
    add_index "gaku_installs", ["reset_password_token"], name: "index_gaku_installs_on_reset_password_token", unique: true, using: :btree

    create_table "gaku_lesson_plans" do |t|
      t.string   "title"
      t.text     "description"
      t.integer  "syllabus_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "notes_count", default: 0
    end

    create_table "gaku_lessons" do |t|
      t.integer  "lesson_plan_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_levels" do |t|
      t.string   "name"
      t.integer  "school_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_notes" do |t|
      t.string   "title"
      t.text     "content"
      t.integer  "notable_id"
      t.string   "notable_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "gaku_notes", ["notable_id", "notable_type"], name: "index_gaku_notes_on_notable_id_and_notable_type", using: :btree

    create_table "gaku_presets" do |t|
      t.string   "name"
      t.string   "content"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_program_levels" do |t|
      t.integer "program_id"
      t.integer "level_id"
    end

    create_table "gaku_program_specialties" do |t|
      t.integer "program_id"
      t.integer "specialty_id"
    end

    create_table "gaku_program_syllabuses" do |t|
      t.integer "program_id"
      t.integer "syllabus_id"
      t.integer "level_id"
    end

    create_table "gaku_programs" do |t|
      t.string   "name"
      t.text     "description"
      t.integer  "school_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_roles" do |t|
      t.string   "name"
      t.integer  "class_group_enrollment_id"
      t.integer  "faculty_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "extracurricular_activity_enrollment_id"
    end

    create_table "gaku_schedules" do |t|
      t.datetime "starting"
      t.datetime "ending"
      t.string   "repeat"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_scholarship_status_translations" do |t|
      t.integer  "gaku_scholarship_status_id", null: false
      t.string   "locale",                     null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "name"
    end

    add_index "gaku_scholarship_status_translations", ["gaku_scholarship_status_id"], name: "index_fd3bb92292a989ddcdc49aabf021ceb1ce5f0d04", using: :btree
    add_index "gaku_scholarship_status_translations", ["locale"], name: "index_gaku_scholarship_status_translations_on_locale", using: :btree

    create_table "gaku_scholarship_statuses" do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "default"
    end

    create_table "gaku_school_histories" do |t|
      t.date     "beginning"
      t.date     "ending"
      t.string   "specialty"
      t.boolean  "graduated"
      t.integer  "school_id"
      t.integer  "student_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_school_roles" do |t|
      t.string   "name"
      t.integer  "school_rolable_id"
      t.string   "school_rolable_type"
      t.integer  "school_role_type_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_school_years" do |t|
      t.date     "starting"
      t.date     "ending"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_schools" do |t|
      t.string   "name"
      t.boolean  "primary",           default: false
      t.text     "slogan"
      t.text     "description"
      t.date     "founded"
      t.string   "principal"
      t.string   "vice_principal"
      t.text     "grades"
      t.string   "code"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "picture_file_name"
      t.string   "picture_content_type"
      t.integer  "picture_file_size"
      t.datetime "picture_updated_at"
    end

    create_table "gaku_semester_class_groups" do |t|
      t.integer  "semester_id"
      t.integer  "class_group_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "gaku_semester_class_groups", ["class_group_id"], name: "index_gaku_semester_class_groups_on_class_group_id", using: :btree
    add_index "gaku_semester_class_groups", ["semester_id"], name: "index_gaku_semester_class_groups_on_semester_id", using: :btree

    create_table "gaku_semester_courses" do |t|
      t.integer  "semester_id"
      t.integer  "course_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "gaku_semester_courses", ["course_id"], name: "index_gaku_semester_courses_on_course_id", using: :btree
    add_index "gaku_semester_courses", ["semester_id"], name: "index_gaku_semester_courses_on_semester_id", using: :btree

    create_table "gaku_semesters" do |t|
      t.date     "starting"
      t.date     "ending"
      t.integer  "school_year_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_simple_grades" do |t|
      t.string   "name"
      t.string   "grade"
      t.integer  "school_id"
      t.integer  "student_id"
      t.integer  "external_school_record_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_specialties" do |t|
      t.string   "name"
      t.text     "description"
      t.boolean  "major_only",  default: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_states" do |t|
      t.string  "name"
      t.string  "abbr"
      t.string  "name_ascii"
      t.integer "code"
      t.string  "country_iso"
    end

    create_table "gaku_student_achievements" do |t|
      t.integer  "student_id"
      t.integer  "achievement_id"
      t.string   "assertion"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_student_guardians" do |t|
      t.integer  "student_id"
      t.integer  "guardian_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_student_specialties" do |t|
      t.integer  "student_id"
      t.integer  "specialty_id"
      t.boolean  "major",     default: true
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_students" do |t|
      t.string   "name"
      t.string   "middle_name"
      t.string   "surname"
      t.string   "name_reading",                 default: ""
      t.string   "middle_name_reading",          default: ""
      t.string   "surname_reading",              default: ""
      t.boolean  "gender"
      t.date     "birth_date"
      t.date     "admitted"
      t.date     "graduated"
      t.string   "student_id_number"
      t.string   "student_foreign_id_number"
      t.string   "national_registration_number"
      t.boolean  "deleted",                   default: false
      t.string   "enrollment_status_code"
      t.string   "picture_file_name"
      t.string   "picture_content_type"
      t.integer  "picture_file_size"
      t.datetime "picture_updated_at"
      t.integer  "user_id"
      t.integer  "faculty_id"
      t.integer  "commute_method_type_id"
      t.integer  "scholarship_status_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "addresses_count",              default: 0
      t.integer  "contacts_count",               default: 0
      t.integer  "notes_count",                  default: 0
      t.integer  "courses_count",                default: 0
      t.integer  "guardians_count",              default: 0
      t.string   "primary_address"
      t.string   "primary_contact"
      t.string   "class_and_number"
    end

    create_table "gaku_syllabuses" do |t|
      t.string   "name"
      t.string   "code"
      t.text     "description"
      t.integer  "credits"
      t.integer  "hours"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "notes_count", default: 0
      t.integer  "exams_count", default: 0
    end

    create_table "gaku_teachers" do |t|
      t.string   "name"
      t.string   "surname"
      t.string   "middle_name"
      t.string   "name_reading",         default: ""
      t.string   "middle_name_reading",  default: ""
      t.string   "surname_reading",      default: ""
      t.boolean  "gender"
      t.date     "birth_date"
      t.boolean  "deleted",           default: false
      t.string   "picture_file_name"
      t.string   "picture_content_type"
      t.integer  "picture_file_size"
      t.datetime "picture_updated_at"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "addresses_count",      default: 0
      t.integer  "contacts_count",       default: 0
      t.integer  "notes_count",          default: 0
    end

    create_table "gaku_templates" do |t|
      t.string   "file_file_name"
      t.string   "file_content_type"
      t.integer  "file_file_size"
      t.datetime "file_updated_at"
      t.string   "name"
      t.string   "context"
      t.boolean  "locked",         default: false
    end

    create_table "gaku_user_roles" do |t|
      t.integer  "user_id"
      t.integer  "role_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "gaku_users" do |t|
      t.boolean  "admin",                  default: false
      t.text     "settings"
      t.string   "locale"
      t.integer  "sign_in_count",          default: 0
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.string   "username"
      t.string   "email"
      t.string   "encrypted_password"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "gaku_users", ["email"], name: "index_gaku_users_on_email", unique: true, using: :btree
    add_index "gaku_users", ["reset_password_token"], name: "index_gaku_users_on_reset_password_token", unique: true, using: :btree
    add_index "gaku_users", ["username"], name: "index_gaku_users_on_username", unique: true, using: :btree

    create_table "gaku_versioning_address_versions" do |t|
      t.string   "item_type",          null: false
      t.integer  "item_id",            null: false
      t.string   "event",              null: false
      t.string   "whodunnit"
      t.text     "object"
      t.text     "object_changes"
      t.string   "join_model"
      t.integer  "joined_resource_id"
      t.datetime "created_at"
    end

    add_index "gaku_versioning_address_versions", ["item_type", "item_id"], name: "index_gaku_versioning_address_versions_on_item_type_and_item_id", using: :btree

    create_table "gaku_versioning_contact_versions" do |t|
      t.string   "item_type",          null: false
      t.integer  "item_id",            null: false
      t.string   "event",              null: false
      t.string   "whodunnit"
      t.text     "object"
      t.text     "object_changes"
      t.string   "join_model"
      t.integer  "joined_resource_id"
      t.datetime "created_at"
    end

    add_index "gaku_versioning_contact_versions", ["item_type", "item_id"], name: "index_gaku_versioning_contact_versions_on_item_type_and_item_id", using: :btree

    create_table "gaku_versioning_student_versions" do |t|
      t.string   "item_type",      null: false
      t.integer  "item_id",        null: false
      t.string   "event",          null: false
      t.string   "whodunnit"
      t.text     "object"
      t.text     "object_changes"
      t.text     "human_changes"
      t.datetime "created_at"
    end

    add_index "gaku_versioning_student_versions", ["item_type", "item_id"], name: "index_gaku_versioning_student_versions_on_item_type_and_item_id", using: :btree

  end
end
