class CreateExamPortionsTable < ActiveRecord::Migration
  def change
  	create_table :exam_portions do |t|
  	  t.string :name
  	  t.float :max_score
  	  t.float :weight

      t.timestamps
  	end
  end
end