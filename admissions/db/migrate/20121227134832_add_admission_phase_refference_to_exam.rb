class AddAdmissionPhaseRefferenceToExam < ActiveRecord::Migration
  def change
    change_table :gaku_exams do |t|
      t.references :admission_phase
    end
  end
end
