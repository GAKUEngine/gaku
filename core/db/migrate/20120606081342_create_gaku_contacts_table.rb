class CreateGakuContactsTable < ActiveRecord::Migration
  def change
    create_table :gaku_contacts do |t|
      t.string   :data
      t.text     :details
      t.boolean  :is_primary,   :default => false
      t.boolean  :is_emergency, :default => false

      t.references :contactable, polymorphic: true
      t.references :contact_type


      t.timestamps
    end
  end
end
