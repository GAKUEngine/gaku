class CreateGakuExamScores < ActiveRecord::Migration
  def change
    create_table :gaku_exam_scores do |t|
      t.float    :score
      t.text     :comment

      t.references :exam
      
      t.timestamps
    end
  end
end
