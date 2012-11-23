class CreateGakuExamScores < ActiveRecord::Migration
  def change
    create_table :gaku_exam_scores do |t|
      t.float    :score
      t.text     :comment

      t.references :exam
      t.references :admission_phase_record

      t.timestamps
    end
  end
end
