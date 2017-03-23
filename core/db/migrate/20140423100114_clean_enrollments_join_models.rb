class CleanEnrollmentsJoinModels < ActiveRecord::Migration[4.2]
  def change
    drop_table :gaku_class_group_enrollments
    drop_table :gaku_class_group_course_enrollments
    drop_table :gaku_course_enrollments
    drop_table :gaku_extracurricular_activity_enrollments
  end
end
