class CreateClassGroupCourseEnrollments < ActiveRecord::Migration
  def change
    create_table :class_group_course_enrollments do |t|
    	t.references :class_group
      t.references :course

      t.timestamps
    end

    add_index :class_group_course_enrollments, :course_id
    add_index :class_group_course_enrollments, :class_group_id
  end
end
