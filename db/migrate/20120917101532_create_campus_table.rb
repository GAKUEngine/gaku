class CreateCampusTable < ActiveRecord::Migration
  
  def change
		create_table :campuses do |t|
  		
  		t.string      :name
  		t.references  :school
  		t.references  :address

  		t.timestamps
  	end  	
  end

end
