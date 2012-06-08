class CreateRolesTable < ActiveRecord::Migration
  def change
	create_table :roles do |t|
      t.integer :faculty_id
      t.string :name
	end
  end
end
