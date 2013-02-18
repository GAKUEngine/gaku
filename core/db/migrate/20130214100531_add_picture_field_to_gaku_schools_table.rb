class AddPictureFieldToGakuSchoolsTable < ActiveRecord::Migration
  def change
    change_table :gaku_schools do |t|
      t.attachment :picture
    end
  end
end
