class CreateExamScores < ActiveRecord::Migration
  def change
    create_table :exam_scores do |t|
      t.references :student
      t.references :exam
      t.float :score
      t.text :comment

      t.timestamps
    end
    add_index :exam_scores, :student_id
    add_index :exam_scores, :exam_id
  end
end
