class AddPictureFieldToGakuCampusesTable < ActiveRecord::Migration
  def change
    change_table :gaku_campuses do |t|
      t.attachment :picture
    end
  end
end
