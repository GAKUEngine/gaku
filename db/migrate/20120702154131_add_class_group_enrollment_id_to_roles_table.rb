class AddClassGroupEnrollmentIdToRolesTable < ActiveRecord::Migration
  def change
  	change_table :roles do |t|
      t.references :class_group_enrollment
  	end
  end
end
