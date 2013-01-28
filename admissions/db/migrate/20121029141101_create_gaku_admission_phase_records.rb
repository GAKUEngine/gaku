class CreateGakuAdmissionPhaseRecords < ActiveRecord::Migration
  def change
  	create_table :gaku_admission_phase_records do |t|
  		t.references :admission
  		t.references :admission_phase
      t.references :admission_phase_state
      t.boolean    :is_deleted, :default => false

      t.timestamps
  	end
  end
end
