class AddExamPortionIdToExamPortionScoresTable < ActiveRecord::Migration
  def change
  	change_table :exam_portion_scores do |t|
  	  t.references :exam_portion
  	end
  end
end
