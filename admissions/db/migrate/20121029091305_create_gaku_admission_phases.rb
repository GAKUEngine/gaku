class CreateGakuAdmissionPhases < ActiveRecord::Migration
  def change
  	create_table :gaku_admission_phases do |t|
  		t.string :name
  		t.integer :order
  		t.integer :phase_handler

  		t.timestamps
  	end
  end
end
