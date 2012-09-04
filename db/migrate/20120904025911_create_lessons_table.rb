class CreateLessonsTable < ActiveRecord::Migration
  def change
  	create_table :lessons do |t|
  		t.timestamps
  	end
  end
end
