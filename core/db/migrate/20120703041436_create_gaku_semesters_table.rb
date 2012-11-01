class CreateGakuSemestersTable < ActiveRecord::Migration
  def change
    create_table :gaku_semesters do |t|
      t.date :starting
 	    t.date :ending

 	    t.references :class_group

 	    t.timestamps
 	  end
  end
end