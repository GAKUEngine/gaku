class AddGenderToStudentsTable < ActiveRecord::Migration
  def change
  	change_table :students do |t|
  	  t.string :gender	
  	end
  end
end