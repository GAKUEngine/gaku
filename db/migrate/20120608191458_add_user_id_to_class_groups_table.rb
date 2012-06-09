class AddUserIdToClassGroupsTable < ActiveRecord::Migration
  def change
  	change_table :class_groups do |t|
      t.references :faculty
  	end
  end
end
