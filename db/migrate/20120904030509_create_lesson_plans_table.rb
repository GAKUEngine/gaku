class CreateLessonPlansTable < ActiveRecord::Migration
  def change
  	create_table :lesson_plans do |t|
  		t.string  :title
  		t.text    :description
  	end
  end
end
