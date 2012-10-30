class CreateGakuCampusesTable < ActiveRecord::Migration
  def change
		create_table :gaku_campuses do |t|
  		t.string      :name
  		t.references  :school
  		t.references  :address
  		t.boolean     :is_master, :default => false

  		t.timestamps
  	end  	
  end
end