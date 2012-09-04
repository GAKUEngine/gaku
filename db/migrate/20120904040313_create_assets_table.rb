class CreateAssetsTable < ActiveRecord::Migration
  def change
  	create_table :assets do |t|
  	  t.timestamps
  	end
  end
end
