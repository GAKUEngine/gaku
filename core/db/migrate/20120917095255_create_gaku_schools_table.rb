class CreateGakuSchoolsTable < ActiveRecord::Migration
  
  def change
		create_table :gaku_schools do |t|
  		t.string      :name
  		t.boolean     :is_primary, :default => false
  		t.text  			:slogan
  		t.text				:description
  		t.date				:founded
  		t.string			:principal
  		t.string			:vice_principal
  		t.text				:grades
      t.string      :code
      
  		t.timestamps
  	end  	
  end
end