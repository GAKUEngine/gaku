class AddGradingMethodIdToExamsTable < ActiveRecord::Migration
  def change
  	change_table :exams do |t|
      t.references :grading_method
  	end
  end
end
