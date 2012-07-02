class AddClassGroupIdToCourses < ActiveRecord::Migration
  def change
  	change_table :courses do |t|
  	  t.references :class_group
  	end
  end
end
