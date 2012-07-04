class AddCourseIdToExamsTable < ActiveRecord::Migration
  def change
  	change_table :exams do |t|
  	  t.references :course
  	end
  end
end
