class CreateGakuSemestersTable < ActiveRecord::Migration
  def change
    create_table :gaku_semesters do |t|
      t.date :starting
 	    t.date :ending

      t.references :school_year

 	    t.timestamps
 	  end
  end
end