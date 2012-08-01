class CreateExamPortionsTable < ActiveRecord::Migration
  def change
  	create_table :exam_portions do |t|
  	  t.string   :name
  	  t.float    :max_score, :weight, :default => 100
  	  t.integer  :problem_count
      t.text     :description, :adjustments
      t.datetime :execution_date
      t.boolean  :dynamic_scoring 
      t.boolean  :is_master,  :default => false

      t.references :exam
      t.references :grading_method

      t.timestamps
  	end
  end
end
