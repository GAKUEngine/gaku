class CreateAssignmentsTable < ActiveRecord::Migration
  def change
  	create_table :assignments do |t|
  		t.string   :name
  		t.text     :description
  		t.integer  :max_score

  		t.timestamps
  	end
  end
end
