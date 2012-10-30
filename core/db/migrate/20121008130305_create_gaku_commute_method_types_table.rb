class CreateGakuCommuteMethodTypesTable < ActiveRecord::Migration
  def change
  	create_table :gaku_commute_method_types do |t|
  		t.string :name
  	end
  end
end
