class CreateContactsTable < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string   :data
      t.text     :details
      t.boolean  :is_primary, :default => false
      t.boolean  :is_emergency, :default => false
      t.timestamps
    end
  end
end