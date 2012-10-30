class CreateGakuLessonsTable < ActiveRecord::Migration
  def change
  	create_table :gaku_lessons do |t|
  		t.references :lesson_plan
  		
  		t.timestamps
  	end
  end
end
