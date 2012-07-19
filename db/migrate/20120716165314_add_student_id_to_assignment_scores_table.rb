class AddStudentIdToAssignmentScoresTable < ActiveRecord::Migration
  def change
  	change_table :assignment_scores do |t|
  		t.references :student
  	end
  end
end
