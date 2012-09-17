class CreateSchoolTable < ActiveRecord::Migration
  
  def change
		create_table :schools do |t|
  		
  		t.string      :name
  		t.boolean     :is_primary, :default => false
  		t.text  			:slogan
  		t.text				:description
  		t.date				:founded
  		t.string			:principal
  		t.string			:vice_principal
  		t.text				:grades

  		t.timestamps
  	end  	
  end

end
