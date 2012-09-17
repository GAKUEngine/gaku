class CreateCampusTable < ActiveRecord::Migration
  
  def change
		create_table :campuses do |t|
  		
  		t.string      :name
  		t.references  :school

  		t.timestamps
  	end  	
  end

end
