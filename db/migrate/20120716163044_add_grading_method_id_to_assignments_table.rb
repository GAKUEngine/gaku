class AddGradingMethodIdToAssignmentsTable < ActiveRecord::Migration
  def change
  	change_table :assignments do |t|
      t.references :grading_method
  	end
  end
end
