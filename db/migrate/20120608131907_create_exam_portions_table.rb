class CreateExamPortionsTable < ActiveRecord::Migration
  def change
  	create_table :exam_portions do |t|
  	  t.string   :name
  	  t.float    :max_score, :weight
  	  t.integer  :problem_count
      t.text     :description, :adjustments
      t.datetime :execution_date
      t.boolean  :dynamic_scoring 
      t.boolean  :is_master,  :default => false

      t.timestamps
  	end
  end
end