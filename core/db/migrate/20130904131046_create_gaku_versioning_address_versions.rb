class CreateGakuVersioningAddressVersions < ActiveRecord::Migration

  def self.up
    create_table :gaku_versioning_address_versions do |t|
      t.string   :item_type, null: false
      t.integer  :item_id,   null: false
      t.string   :event,     null: false
      t.string   :whodunnit
      t.text     :object
      t.text     :object_changes
      t.string   :join_model
      t.integer  :joined_resource_id
      t.datetime :created_at
    end
    add_index :gaku_versioning_address_versions, [:item_type, :item_id]
  end


  def self.down
    remove_index :gaku_versioning_address_versions, [:item_type, :item_id]
    drop_table :gaku_versioning_address_versions
  end

end
