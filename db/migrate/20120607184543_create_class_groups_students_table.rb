class CreateClassGroupsStudentsTable < ActiveRecord::Migration
  def change
  	create_table :class_groups_students do |t|
      t.references :class_group
      t.references :student
  	end
  end
end