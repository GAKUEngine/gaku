class CreateContactsTable < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string   :data
      t.text     :details
      t.boolean  :is_primary, :default => false
      t.boolean  :is_emergency, :default => false

      t.references :contact_type
      t.references :student
      t.references :guardian
      t.references :faculty
      t.references :campus

      
      t.timestamps
    end
  end
end