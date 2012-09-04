class CreateAttendancesTable < ActiveRecord::Migration
  def change
  	create_table :attendances do |t|
  		t.string :reason
  		t.text :description
  		
  		t.timestamps
  	end
  end
end
