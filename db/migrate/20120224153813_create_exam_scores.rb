class CreateExamScores < ActiveRecord::Migration
  def change
    create_table :exam_scores do |t|
      t.float    :score
      t.text     :comment

      t.timestamps
    end
  end
end
