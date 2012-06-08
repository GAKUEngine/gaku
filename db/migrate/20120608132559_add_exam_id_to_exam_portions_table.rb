class AddExamIdToExamPortionsTable < ActiveRecord::Migration
  def change
  	change_table :exam_portions do |t|
  	  t.references :exam
  	end
  end
end
