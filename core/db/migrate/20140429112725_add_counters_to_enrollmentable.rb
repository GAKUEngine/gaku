class AddCountersToEnrollmentable < ActiveRecord::Migration[4.2]
  def change
    add_column :gaku_courses, :enrollments_count, :integer, default: 0, null: false
    add_column :gaku_class_groups, :enrollments_count, :integer, default: 0, null: false
    add_column :gaku_extracurricular_activities, :enrollments_count, :integer, default: 0, null: false
    add_column :gaku_exam_sessions, :enrollments_count, :integer, default: 0, null: false

    #for courses already exist
    add_column :gaku_students, :extracurricular_activities_count, :integer, default: 0, null: false
    add_column :gaku_students, :class_groups_count, :integer, default: 0, null: false
    add_column :gaku_students, :exam_sessions_count, :integer, default: 0, null: false
  end
end
