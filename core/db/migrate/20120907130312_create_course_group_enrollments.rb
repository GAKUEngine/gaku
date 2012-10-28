class CreateCourseGroupEnrollments < ActiveRecord::Migration
  def change
  	create_table :gaku_course_group_enrollments do |t|
  	  t.references :course
  		t.references :course_group
  	end
  end
end
