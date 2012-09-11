class CreateCourseGroupEnrollments < ActiveRecord::Migration
  def change
  	create_table :course_group_enrollments do |t|
  		t.references :course
  		t.references :course_group
  	end
  end
end
