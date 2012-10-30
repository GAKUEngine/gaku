class AddPictureToGakuStudent < ActiveRecord::Migration
  def change
    add_attachment :gaku_students, :picture
  end
end
