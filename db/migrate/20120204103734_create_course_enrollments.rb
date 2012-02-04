class CreateCourseEnrollments < ActiveRecord::Migration
  def change
    create_table :course_enrollments do |t|
      t.references :student
      t.references :course

      t.timestamps
    end
    add_index :course_enrollments, :student_id
    add_index :course_enrollments, :course_id
  end
end
