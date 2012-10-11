class CreateCommuteMethodTable < ActiveRecord::Migration
  def change
  	create_table :commute_methods do |t|
  		t.text :details

  		t.references :commute_method_type
  	end
  end
end