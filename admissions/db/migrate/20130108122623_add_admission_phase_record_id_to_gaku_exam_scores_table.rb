class AddAdmissionPhaseRecordIdToGakuExamScoresTable < ActiveRecord::Migration
  def change
    change_table :gaku_exam_scores do |t|
      t.references :admission_phase_record
    end
  end
end
