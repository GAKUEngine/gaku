class CreateGakuAttendancesTable < ActiveRecord::Migration
  def change
  	create_table :gaku_attendances do |t|
  		t.string :reason
  		t.text :description
      
  		t.references :attendancable, :polymorphic => true
      t.references :student
  		
  		t.timestamps
  	end
  end
end
