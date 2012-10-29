class CreateCourseEnrollments < ActiveRecord::Migration
  def change
    create_table :gaku_course_enrollments do |t|
      t.references :student
      t.references :course

      t.timestamps
    end
    add_index :gaku_course_enrollments, :student_id
    add_index :gaku_course_enrollments, :course_id
  end
end
