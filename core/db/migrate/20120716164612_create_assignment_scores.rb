class CreateAssignmentScores < ActiveRecord::Migration
  def change
    create_table :gaku_assignment_scores do |t|
      t.integer :score

      t.references :student

      t.timestamps
    end
  end
end
