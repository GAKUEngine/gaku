class CreateExamPortionScoresTable < ActiveRecord::Migration
  def change 
  	create_table :exam_portion_scores do |t|
  	  t.float    :score
  	  t.integer  :division
  	  t.text   :comment
  	  
  	  t.timestamps
   	end
  end
end
