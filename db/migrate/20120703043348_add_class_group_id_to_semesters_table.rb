class AddClassGroupIdToSemestersTable < ActiveRecord::Migration
  def change
  	change_table :semesters do |t|
      t.references :class_group
  	end
  end
end
