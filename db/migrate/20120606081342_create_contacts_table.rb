class CreateContactsTable < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string   :data
      t.text     :details
      t.boolean  :is_primary
      t.boolean  :is_emergency
      t.timestamps
    end
  end
end