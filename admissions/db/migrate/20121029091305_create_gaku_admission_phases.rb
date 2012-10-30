class CreateGakuAdmissionPhases < ActiveRecord::Migration
  def change
  	create_table :gaku_admission_phases do |t|
  		t.string      :name
  		t.integer     :order
  		t.integer     :phase_handler
  		t.references  :admission_method

  		t.timestamps
  	end
  end
end
