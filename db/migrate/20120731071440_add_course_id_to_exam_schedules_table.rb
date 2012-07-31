class AddCourseIdToExamSchedulesTable < ActiveRecord::Migration
  def change
  	change_table :exam_schedules do |t|
      t.references :course
  	end
  end
end
