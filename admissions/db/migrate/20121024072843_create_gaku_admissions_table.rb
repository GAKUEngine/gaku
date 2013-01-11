class CreateGakuAdmissionsTable < ActiveRecord::Migration
  def change
    create_table :gaku_admissions do |t|
      t.boolean     :admitted

      t.references  :student
      t.references  :admission_method
      t.references  :admission_period
      t.references  :scholarship_status
      t.references  :school_history
      t.references  :admission_phase_record

      t.boolean     :is_deleted, :default => false

      t.timestamps
    end
  end
end
