class CreateGakuSpecialtyApplications < ActiveRecord::Migration
  def change
  	create_table :gaku_specialty_applications do |t|
  		t.integer     :rank
  		t.references  :specialty

  		t.timestamps
  	end
  end
end
