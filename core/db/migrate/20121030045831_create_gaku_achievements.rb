class CreateGakuAchievements < ActiveRecord::Migration
  def change
  	create_table :gaku_achievements do |t|
  		t.string      :name
  		t.text        :description
  		t.references  :student

  		t.timestamps
  	end
  end
end
