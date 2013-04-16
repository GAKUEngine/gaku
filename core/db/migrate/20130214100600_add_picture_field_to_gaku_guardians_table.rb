class AddPictureFieldToGakuGuardiansTable < ActiveRecord::Migration
  def change
    change_table :gaku_guardians do |t|
      t.attachment :picture
    end
  end
end
