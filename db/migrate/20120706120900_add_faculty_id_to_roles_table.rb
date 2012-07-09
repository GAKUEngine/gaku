class AddFacultyIdToRolesTable < ActiveRecord::Migration
  def change
  	change_table :roles do |t|
  		t.references :faculty
  	end
  end
end
