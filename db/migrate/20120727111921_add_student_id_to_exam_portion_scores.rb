class AddStudentIdToExamPortionScores < ActiveRecord::Migration
  def change
    change_table :exam_portion_scores do |t|
      t.references :student
    end
  end
end
