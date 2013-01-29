class AddExternalSchoolRecordIdToGakuAchievementsTable < ActiveRecord::Migration
  def change
    change_table :gaku_achievements do |t|
      t.references :external_school_record
    end 
  end
end
