class AddScheduleIdToExamPortionsTable < ActiveRecord::Migration
  def change
  	change_table :exam_portions do |t|
      t.references :schedule
  	end
  end
end
