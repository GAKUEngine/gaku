class CreateGakuClassGroupCourseEnrollments < ActiveRecord::Migration
  def change
    create_table :gaku_class_group_course_enrollments do |t|
    	t.references :class_group
      t.references :course

      t.timestamps
    end
  end
end
