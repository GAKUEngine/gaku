class AddContactTypeIdToContactsTable < ActiveRecord::Migration
  def change
    change_table :contacts do |t|
      t.references :contact_type
    end
  end
end