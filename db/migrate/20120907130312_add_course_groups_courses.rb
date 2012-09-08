class AddCourseGroupsCourses < ActiveRecord::Migration
  def change
  	create_table :course_groups_courses do |t|
  		t.references :course
  		t.references :course_group
  	end
  end
end
