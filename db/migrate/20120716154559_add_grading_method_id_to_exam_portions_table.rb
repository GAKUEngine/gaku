class AddGradingMethodIdToExamPortionsTable < ActiveRecord::Migration
  def change
  	change_table :exam_portions do |t|
      t.references :grading_method
  	end
  end
end
