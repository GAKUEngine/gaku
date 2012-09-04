class CreateAttendancesTable < ActiveRecord::Migration
  def change
  	create_table :attendances do |t|
  		t.string :reason
  		t.text :description
  		t.integer :attendancable_id
  		t.string  :attendancable_type
      t.references :student
  		
  		t.timestamps
  	end
  end
end
