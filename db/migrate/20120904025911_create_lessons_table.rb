class CreateLessonsTable < ActiveRecord::Migration
  def change
  	create_table :lessons do |t|
  		t.references :lesson_plan
  		
  		t.timestamps
  	end
  end
end
