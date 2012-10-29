class CreateEnrollmentStatusesTable < ActiveRecord::Migration
  def change
  	create_table :gaku_enrollment_statuses do |t|
  		t.references :enrollment_status_type
  		t.references :student

  		t.timestamps
  	end
  end
end
