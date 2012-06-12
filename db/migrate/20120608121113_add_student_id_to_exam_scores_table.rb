class AddStudentIdToExamScoresTable < ActiveRecord::Migration
  def change
  	change_table :exam_scores do |t|
      t.references :student
  	end
  end
end
