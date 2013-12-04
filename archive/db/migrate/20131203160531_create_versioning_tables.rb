class CreateVersioningTables < ActiveRecord::Migration
  def change

    create_table 'gaku_versioning_address_versions' do |t|
      t.string   'item_type',          null: false
      t.integer  'item_id',            null: false
      t.string   'event',              null: false
      t.string   'whodunnit'
      t.text     'object'
      t.text     'object_changes'
      t.string   'join_model'
      t.integer  'joined_resource_id'
      t.datetime 'created_at'
    end

    add_index 'gaku_versioning_address_versions', ['item_type', 'item_id'], name: 'index_gaku_versioning_address_versions_on_item_fields', using: :btree

    create_table 'gaku_versioning_contact_versions' do |t|
      t.string   'item_type',          null: false
      t.integer  'item_id',            null: false
      t.string   'event',              null: false
      t.string   'whodunnit'
      t.text     'object'
      t.text     'object_changes'
      t.string   'join_model'
      t.integer  'joined_resource_id'
      t.datetime 'created_at'
    end

    add_index 'gaku_versioning_contact_versions', ['item_type', 'item_id'], name: 'index_gaku_versioning_contact_versions_on_item_fields', using: :btree

    create_table 'gaku_versioning_student_versions' do |t|
      t.string   'item_type',      null: false
      t.integer  'item_id',        null: false
      t.string   'event',          null: false
      t.string   'whodunnit'
      t.text     'object'
      t.text     'object_changes'
      t.text     'human_changes'
      t.datetime 'created_at'
    end

    add_index 'gaku_versioning_student_versions', ['item_type', 'item_id'], name: 'index_gaku_versioning_student_versions_on_item_fields', using: :btree


  end
end
