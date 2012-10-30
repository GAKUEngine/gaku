class CreateGakuRolesTable < ActiveRecord::Migration
  def change
	  create_table :gaku_roles do |t|
      t.string   :name

      t.references :class_group_enrollment
      t.references :faculty
      
	  end
  end
end
