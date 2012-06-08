class AddStudentIdToNotesTable < ActiveRecord::Migration
  def change
  	change_table :notes do |t|
  	  t.references :student
  	end
  end
end
