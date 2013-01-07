class CreateGakuAdmissionsTable < ActiveRecord::Migration
  def change
    create_table :gaku_admissions do |t|
      t.boolean     :admitted
      t.integer     :deleted, :default => 0

      t.references  :student
      t.references  :admission_method
      t.references  :admission_period
      t.references  :scholarship_status
      t.references  :school_history
      t.references  :admission_phase_record

      t.timestamps
    end
  end
end
