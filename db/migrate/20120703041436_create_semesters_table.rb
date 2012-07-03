class CreateSemestersTable < ActiveRecord::Migration
  def change
 	  create_table :semesters do |t|
 		  t.date :starting
 		  t.date :ending
 	  end
  end
end
