class CreateGakuAchievements < ActiveRecord::Migration
  def change
  	create_table :gaku_achievements do |t|
  		t.string      :name
  		t.text        :description
      t.string      :authority

      t.attachment  :badge

      t.references :external_school_record

      t.timestamps
  	end
  end
end
