class CreateExamPortionScoresTable < ActiveRecord::Migration
  def change 
  	create_table :exam_portion_scores do |t|
  	  t.float    :score
  	  
  	  t.timestamps
   	end
  end
end
