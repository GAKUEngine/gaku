class AddSyllabusIdToAssignmentsTable < ActiveRecord::Migration
  def change
  	change_table :assignments do |t|
  		t.references :syllabus
  	end
  end
end
