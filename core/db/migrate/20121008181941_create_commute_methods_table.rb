class CreateCommuteMethodsTable < ActiveRecord::Migration
  def change
  	create_table :gaku_commute_methods do |t|
  		t.text :details

  		t.references :commute_method_type
  	end
  end
end