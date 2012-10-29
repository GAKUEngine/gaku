class CreateExamSchedulesTable < ActiveRecord::Migration
  def change 
  	create_table :gaku_exam_schedules do |t|
  		t.references :exam_portion
  		t.references :schedule
  		t.references :course
  	end
  end
end
