class CreateGakuCampusesTable < ActiveRecord::Migration
  def change
		create_table :gaku_campuses do |t|
  		t.string      :name
  		t.boolean     :is_master, :default => false

      t.references  :school

  		t.timestamps
  	end
  end
end
