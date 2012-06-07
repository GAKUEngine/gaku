class AddExamIdToExamScoresTable < ActiveRecord::Migration
  def change
  	change_table :exam_scores do |t|
      t.references :exam
    end
  end
end
