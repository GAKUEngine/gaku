class CreateGakuSpecialtyApplications < ActiveRecord::Migration
  def change
  	create_table :gaku_specialty_applications do |t|
  		t.integer     :rank
  		t.references  :specialty
  		t.references  :admission

  		t.timestamps
  	end
  end
end
