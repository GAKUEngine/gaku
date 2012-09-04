class CreateAssetsTable < ActiveRecord::Migration
  def change
  	create_table :assets do |t|
  		t.references :exam_portion
  		t.references :lesson_plan

  	  t.timestamps
  	end
  end
end
