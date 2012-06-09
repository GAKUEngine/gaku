class AddScheduleIdToExams < ActiveRecord::Migration
  def change
  	change_table :exams do |t|
      t.references :schedule
  	end
  end
end
