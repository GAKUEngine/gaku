class AddPrimaryAddressAndPrimaryContactToGakuStudentsTable < ActiveRecord::Migration
  def change
    change_table :gaku_students do |t|
      t.string :primary_address
      t.string :primary_contact
    end
  end
end
