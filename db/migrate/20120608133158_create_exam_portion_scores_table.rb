class CreateExamPortionScoresTable < ActiveRecord::Migration
  def change 
  	create_table :exam_portion_scores do |t|
  	  t.float    :score

  	  t.references :exam_portion
  	  t.references :student
  	  
  	  t.timestamps
   	end
  end
end
