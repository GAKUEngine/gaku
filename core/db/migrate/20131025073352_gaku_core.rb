require 'gaku/migrations'

class GakuCore < ActiveRecord::Migration

  include Gaku::Migrations

  def change
    create_table :gaku_badge_types do |t|
      t.string   :name
      t.string   :code
      t.text     :description
      t.string   :authority
      t.string   :issuer
      t.string   :url
      t.attachment  :badge_image
      t.timestamps
    end

    create_table :gaku_addresses do |t|
      t.string   :address1
      t.string   :address2
      t.string   :city
      t.string   :zipcode
      t.string   :title
      t.boolean  :primary,       default: false
      t.references :addressable, polymorphic: true
      t.references :country
      t.references :state
      t.timestamps
    end
    add_index :gaku_addresses, :country_id
    add_index :gaku_addresses, :state_id
    add_index :gaku_addresses, [:addressable_id, :addressable_type]


    create_table :gaku_assignment_scores do |t|
      t.float    :score
      t.references  :student
      t.timestamps
    end
    add_index :gaku_assignment_scores, :student_id

    create_table :gaku_assignments do |t|
      t.string   :name
      t.text     :description
      t.integer  :max_score
      t.references  :syllabus
      t.references  :grading_method
      t.timestamps
    end

    create_table :gaku_attachments do |t|
      t.string   :name
      t.text     :description
      t.attachment :asset
      t.references :attachable, polymorphic: true
      t.timestamps
    end
    add_index :gaku_attachments, [:attachable_id, :attachable_type]


    create_table :gaku_attendances do |t|
      t.text    :reason
      t.references :attendancable, polymorphic: true
      t.references :student
      t.references  :attendance_type
      t.timestamps
    end
    add_index :gaku_attendances, :student_id
    add_index :gaku_attendances, :attendance_type_id

    create_table :gaku_campuses do |t|
      t.string   :name
      t.boolean  :master,            default: false
      t.attachment :picture
      t.counters :contacts, :addresses
      t.references  :school
      t.timestamps
    end
    add_index :gaku_campuses, :school_id

    create_table :gaku_class_group_course_enrollments do |t|
      t.references :class_group
      t.references :course
      t.timestamps
    end
    add_index :gaku_class_group_course_enrollments, :class_group_id
    add_index :gaku_class_group_course_enrollments, :course_id

    create_table :gaku_class_group_enrollments do |t|
      t.integer  :seat_number
      t.references  :class_group
      t.references  :student
      t.timestamps
    end
    add_index :gaku_class_group_enrollments, :class_group_id
    add_index :gaku_class_group_enrollments, :student_id

    create_table :gaku_class_groups do |t|
      t.string   :name
      t.integer  :grade
      t.string   :homeroom
      t.counters :notes
      t.references  :faculty
      t.timestamps
    end
    add_index :gaku_class_groups, :faculty_id

    create_table :gaku_contact_types do |t|
      t.string :name
      t.timestamps
    end
    add_index :gaku_contact_types, :name, unique: true

    create_table :gaku_contacts do |t|
      t.string   :data
      t.text     :details
      t.boolean  :primary,       default: false
      t.boolean  :emergency,     default: false
      t.references :contactable, polymorphic: true
      t.references  :contact_type
      t.timestamps
    end
    add_index :gaku_contacts, :contact_type_id
    add_index :gaku_contacts, [:contactable_id, :contactable_type]


    create_table :gaku_countries do |t|
      t.string  :iso_name
      t.string  :iso
      t.string  :iso3
      t.string  :name
      t.integer :numcode
      t.timestamps
    end
    add_index :gaku_countries, :iso, unique: true

    create_table :gaku_course_enrollments do |t|
      t.references :student
      t.references :course
      t.timestamps
    end
    add_index :gaku_course_enrollments, :student_id
    add_index :gaku_course_enrollments, :course_id

    create_table :gaku_course_group_enrollments do |t|
      t.references :course
      t.references :course_group
      t.timestamps
    end
    add_index :gaku_course_group_enrollments, :course_id
    add_index :gaku_course_group_enrollments, :course_group_id

    create_table :gaku_course_groups do |t|
      t.string  :name
      t.timestamps
    end
    add_index :gaku_course_groups, :name

    create_table :gaku_courses do |t|
      t.string   :name
      t.string   :code
      t.counters :notes, :students
      t.references  :faculty
      t.references  :syllabus
      t.references  :class_group
      t.timestamps
    end
    add_index :gaku_courses, :code
    add_index :gaku_courses, :faculty_id
    add_index :gaku_courses, :syllabus_id
    add_index :gaku_courses, :class_group_id


    create_table :gaku_exam_portion_scores do |t|
      t.float    :score
      t.string   :entry_number
      t.references  :exam_portion
      t.references  :student
      t.timestamps
    end
    add_index :gaku_exam_portion_scores, :exam_portion_id
    add_index :gaku_exam_portion_scores, :student_id

    create_table :gaku_exam_portions do |t|
      t.string   :name
      t.float    :max_score
      t.float    :weight
      t.integer  :problem_count
      t.text     :description
      t.text     :adjustments
      t.integer  :position
      t.references  :exam
      t.references  :grading_method
      t.timestamps
    end
    add_index :gaku_exam_portions, :exam_id
    add_index :gaku_exam_portions, :grading_method_id

    create_table :gaku_exam_schedules do |t|
      t.references :exam_portion
      t.references :schedule
      t.references :course
      t.timestamps
    end
    add_index :gaku_exam_schedules, :exam_portion_id
    add_index :gaku_exam_schedules, :schedule_id
    add_index :gaku_exam_schedules, :course_id

    create_table :gaku_exam_scores do |t|
      t.float    :score
      t.text     :comment
      t.references  :exam
      t.timestamps
    end
    add_index :gaku_exam_scores, :exam_id

    create_table :gaku_exam_syllabuses do |t|
      t.references :exam
      t.references :syllabus
      t.timestamps
    end
    add_index :gaku_exam_syllabuses, :exam_id
    add_index :gaku_exam_syllabuses, :syllabus_id

    create_table :gaku_exams do |t|
      t.string   :name
      t.text     :description
      t.text     :adjustments
      t.float    :weight
      t.boolean  :use_weighting,     default: false
      t.boolean  :standalone,     default: false
      t.boolean  :has_entry_numbers, default: false
      t.counters :notes, :exam_portions
      t.references  :grading_method
      t.references :department
      t.timestamps
    end
    add_index :gaku_exams, :name
    add_index :gaku_exams, :grading_method_id
    add_index :gaku_exams, :department_id


    create_table :gaku_external_school_records do |t|
      t.date     :beginning
      t.date     :ending
      t.string   :student_id_number
      t.integer  :absences
      t.float    :attendance_rate
      t.boolean  :graduated
      t.text     :data
      t.references  :school
      t.references  :student
      t.timestamps
    end
    add_index :gaku_external_school_records, :school_id
    add_index :gaku_external_school_records, :student_id

    create_table :gaku_extracurricular_activities do |t|
      t.string   :name
      t.timestamps
    end
    add_index :gaku_extracurricular_activities, :name, unique: true

    create_table :gaku_extracurricular_activity_enrollments do |t|
      t.references  :extracurricular_activity
      t.references  :student
      t.timestamps
    end
    add_index :gaku_extracurricular_activity_enrollments, :extracurricular_activity_id, name: 'ex_activity_enrollments_ex_activity_id'
    add_index :gaku_extracurricular_activity_enrollments, :student_id, name: 'ex_activity_enrollments_student_id'

    create_table :gaku_faculties do |t|
      t.references  :user
      t.timestamps
    end

    create_table :gaku_grading_method_set_items do |t|
      t.integer  :position
      t.references :grading_method
      t.references  :grading_method_set
      t.timestamps
    end
    add_index :gaku_grading_method_set_items, :grading_method_id, name: 'index_gaku_grading_method_set_items_on_grading_method_id', using: :btree
    add_index :gaku_grading_method_set_items, :grading_method_set_id, name: 'index_gaku_grading_method_set_items_on_grading_method_set_id', using: :btree

    create_table :gaku_grading_method_sets do |t|
      t.string   :name
      t.boolean  :primary,           default: false
      t.boolean  :display_deviation, default: true
      t.boolean  :display_rank,      default: true
      t.boolean  :rank_order,        default: true
      t.timestamps
    end
    add_index :gaku_grading_method_sets, :name, unique: true

    create_table :gaku_grading_methods do |t|
      t.string   :name
      t.text     :description
      t.text     :method
      t.hstore   :arguments
      t.boolean  :curved,      default: true
      t.timestamps
    end
    add_index :gaku_grading_methods, :name, unique: true

    create_table :gaku_guardians do |t|
      t.person_fields
      t.string   :relationship
      t.attachment :picture
      t.string   :primary_address
      t.string   :primary_contact
      t.counters :addresses, :contacts
      t.references  :user
      t.timestamps
    end
    add_index :gaku_guardians, :user_id


    create_table :gaku_installs do |t|
      t.string   :email,                  default: '', null: false
      t.string   :encrypted_password,     default: '', null: false
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count,          default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.timestamps
    end

    add_index :gaku_installs, :email, name: 'index_gaku_installs_on_email', unique: true, using: :btree
    add_index :gaku_installs, :reset_password_token, name: 'index_gaku_installs_on_reset_password_token', unique: true, using: :btree

    create_table :gaku_lesson_plans do |t|
      t.string   :title
      t.text     :description
      t.counters :notes
      t.references  :syllabus
      t.timestamps
    end
    add_index :gaku_lesson_plans, :syllabus_id

    create_table :gaku_lessons do |t|
      t.references  :lesson_plan
      t.timestamps
    end
    add_index :gaku_lessons, :lesson_plan_id

    create_table :gaku_levels do |t|
      t.string   :name
      t.references  :school
      t.timestamps
    end
    add_index :gaku_levels, :name, unique: true
    add_index :gaku_levels, :school_id

    create_table :gaku_notes do |t|
      t.string   :title
      t.text     :content
      t.references :notable, polymorphic: true
      t.timestamps
    end
    add_index :gaku_notes, [:notable_id, :notable_type], using: :btree

    create_table :gaku_program_levels do |t|
      t.references :program
      t.references :level
      t.timestamps
    end
    add_index :gaku_program_levels, :program_id
    add_index :gaku_program_levels, :level_id

    create_table :gaku_program_specialties do |t|
      t.references :program
      t.references :specialty
      t.timestamps
    end
    add_index :gaku_program_specialties, :program_id
    add_index :gaku_program_specialties, :specialty_id

    create_table :gaku_program_syllabuses do |t|
      t.references :program
      t.references :syllabus
      t.references :level
      t.timestamps
    end
    add_index :gaku_program_syllabuses, :program_id
    add_index :gaku_program_syllabuses, :syllabus_id
    add_index :gaku_program_syllabuses, :level_id

    create_table :gaku_programs do |t|
      t.string   :name
      t.text     :description
      t.references  :school
      t.timestamps
    end
    add_index :gaku_programs, :name, unique: true
    add_index :gaku_programs, :school_id

    create_table :gaku_roles do |t|
      t.string   :name
      t.timestamps
    end
    add_index :gaku_roles, :name, unique: true

    create_table :gaku_schedules do |t|
      t.datetime :starting
      t.datetime :ending
      t.string   :repeat
      t.timestamps
    end

    create_table :gaku_school_roles do |t|
      t.string   :name
      t.references :school_rolable, polymorphic: true
      t.timestamps
    end
    add_index :gaku_school_roles, :name, unique: true
    add_index :gaku_school_roles, [:school_rolable_id, :school_rolable_type], name: 'index_gaku_school_roles_school_rolable_fields'

    create_table :gaku_school_years do |t|
      t.date     :starting
      t.date     :ending
      t.timestamps
    end

    create_table :gaku_schools do |t|
      t.string   :name
      t.boolean  :primary,           default: false
      t.text     :slogan
      t.text     :description
      t.date     :founded
      t.string   :principal
      t.string   :vice_principal
      t.text     :grades
      t.string   :code
      t.attachment :picture
      t.timestamps
    end
    add_index :gaku_schools, :name, unique: true

    create_table :gaku_semester_class_groups do |t|
      t.references  :semester
      t.references  :class_group
      t.timestamps
    end
    add_index :gaku_semester_class_groups, :class_group_id, name: 'index_gaku_semester_class_groups_on_class_group_id', using: :btree
    add_index :gaku_semester_class_groups, :semester_id, name: 'index_gaku_semester_class_groups_on_semester_id', using: :btree

    create_table :gaku_semester_courses do |t|
      t.references  :semester
      t.references  :course
      t.timestamps
    end
    add_index :gaku_semester_courses, :course_id, name: 'index_gaku_semester_courses_on_course_id', using: :btree
    add_index :gaku_semester_courses, :semester_id, name: 'index_gaku_semester_courses_on_semester_id', using: :btree

    create_table :gaku_semesters do |t|
      t.date     :starting
      t.date     :ending
      t.references  :school_year
      t.timestamps
    end
    add_index :gaku_semesters, :school_year_id

    create_table :gaku_simple_grades do |t|
      t.string   :name
      t.string   :grade
      t.references  :school
      t.references  :student
      t.references  :external_school_record
      t.timestamps
    end
    add_index :gaku_simple_grades, :school_id
    add_index :gaku_simple_grades, :student_id
    add_index :gaku_simple_grades, :external_school_record_id

    create_table :gaku_specialties do |t|
      t.string   :name
      t.text     :description
      t.boolean  :major_only,  default: false
      t.references :department
      t.timestamps
    end
    add_index :gaku_specialties, :name, unique: true
    add_index :gaku_specialties, :department_id

    create_table :gaku_states do |t|
      t.string  :name
      t.string  :abbr
      t.string  :name_ascii
      t.integer :code
      t.string  :country_iso
      t.timestamps
    end
    add_index :gaku_states, :country_iso

    create_table :gaku_badges do |t|
      t.string   :url
      t.date     :award_date
      t.references  :student
      t.references  :badge_type
      t.timestamps
    end
    add_index :gaku_badges, :student_id
    add_index :gaku_badges, :badge_type_id

    create_table :gaku_student_guardians do |t|
      t.references  :student
      t.references  :guardian
      t.timestamps
    end
    add_index :gaku_student_guardians, :student_id
    add_index :gaku_student_guardians, :guardian_id

    create_table :gaku_student_specialties do |t|
      t.references  :student
      t.references  :specialty
      t.boolean  :major,     default: true
      t.timestamps
    end
    add_index :gaku_student_specialties, :student_id
    add_index :gaku_student_specialties, :specialty_id

    create_table :gaku_students do |t|
      t.person_fields
      t.date     :admitted
      t.date     :graduated
      t.string   :code
      t.string   :serial_id
      t.string   :foreign_id_code
      t.string   :national_registration_code
      t.string   :enrollment_status_code
      t.attachment :picture
      t.counters :addresses, :contacts, :notes, :courses, :guardians, :external_school_records, :badges
      t.string   :primary_address
      t.string   :primary_contact
      t.string   :class_and_number
      t.references  :user
      t.references  :faculty
      t.references  :commute_method_type
      t.references  :scholarship_status
      t.timestamps
    end
    add_index :gaku_students, :user_id
    add_index :gaku_students, :faculty_id
    add_index :gaku_students, :commute_method_type_id
    add_index :gaku_students, :scholarship_status_id
    add_index :gaku_students, :enrollment_status_code


    create_table :gaku_syllabuses do |t|
      t.string   :name
      t.string   :code
      t.text     :description
      t.integer  :credits
      t.integer  :hours
      t.counters :notes, :exams
      t.references :department
      t.timestamps
    end
    add_index :gaku_syllabuses, :department_id

    create_table :gaku_teachers do |t|
      t.person_fields
      t.attachment :picture
      t.string   :primary_address
      t.string   :primary_contact
      t.counters :addresses, :contacts, :notes
      t.references  :user
      t.timestamps
    end
    add_index :gaku_teachers, :user_id


    create_table :gaku_templates do |t|
      t.attachment :file
      t.string   :name
      t.string   :context
      t.boolean  :locked,         default: false
      t.timestamps
    end

    create_table :gaku_user_roles do |t|
      t.references  :user
      t.references  :role
      t.timestamps
    end
    add_index :gaku_user_roles, :user_id
    add_index :gaku_user_roles, :role_id

    create_table :gaku_users do |t|
      t.boolean  :admin,                  default: false
      t.text     :settings
      t.string   :locale
      t.integer  :sign_in_count,          default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string   :username
      t.string   :email
      t.string   :encrypted_password
      t.timestamps
    end

    add_index 'gaku_users', ['email'], name: 'index_gaku_users_on_email', unique: true, using: :btree
    add_index 'gaku_users', ['reset_password_token'], name: 'index_gaku_users_on_reset_password_token', unique: true, using: :btree
    add_index 'gaku_users', ['username'], name: 'index_gaku_users_on_username', unique: true, using: :btree


  end
end
