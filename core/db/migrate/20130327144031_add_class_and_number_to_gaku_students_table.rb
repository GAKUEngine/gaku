class AddClassAndNumberToGakuStudentsTable < ActiveRecord::Migration
  def change
    change_table :gaku_students do |t|
      t.string :class_and_number
    end
  end
end
