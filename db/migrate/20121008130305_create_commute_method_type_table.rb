class CreateCommuteMethodTypeTable < ActiveRecord::Migration
  def change
  	create_table :commute_method_types do |t|
  		t.string :name
  	end
  end
end
