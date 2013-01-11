class CreateGakuCourseEnrollments < ActiveRecord::Migration
  def change
    create_table :gaku_course_enrollments do |t|
      t.references :student
      t.references :course

      t.timestamps
    end
  end
end
