class CreateGakuAdmissionPhaseRecords < ActiveRecord::Migration
  def change
  	create_table :gaku_admission_phase_records do |t|
  		t.references :admission
  		t.references :admission_phase
      t.references :admission_phase_state
      t.integer    :is_deleted, :default => 0

      t.timestamps
  	end
  end
end
