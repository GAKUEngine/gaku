class CreateAssignmentScores < ActiveRecord::Migration
  def change
    create_table :assignment_scores do |t|
      t.integer :score

      t.references :student

      t.timestamps
    end
  end
end
