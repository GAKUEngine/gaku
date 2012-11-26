class CreateGakuAttendanceTypesTable < ActiveRecord::Migration
 def change
  	create_table :gaku_attendance_types do |t|
  		t.string :name
  		t.string :color_code
  		t.boolean :counted_absent
  		t.boolean :disable_credit

      t.timestamps
  	end
  end
end
