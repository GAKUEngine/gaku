class CreateGakuExamPortionsTable < ActiveRecord::Migration
  def change
  	create_table :gaku_exam_portions do |t|
  	  t.string   :name
  	  t.float    :max_score
      t.float    :weight, :default => 100
  	  t.integer  :problem_count
      t.text     :description, :adjustments
      t.boolean  :is_master,  :default => false
      t.integer  :position

      t.references :exam
      t.references :grading_method

      t.timestamps
  	end
  end
end
