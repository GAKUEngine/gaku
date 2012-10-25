class InstallAudited < ActiveRecord::Migration
  def self.up
    create_table :gaku_audits, :force => true do |t|
      t.column :auditable_id, :integer
      t.column :auditable_type, :string
      t.column :associated_id, :integer
      t.column :associated_type, :string
      t.column :user_id, :integer
      t.column :user_type, :string
      t.column :username, :string
      t.column :action, :string
      t.column :audited_changes, :text
      t.column :version, :integer, :default => 0
      t.column :comment, :string
      t.column :remote_address, :string
      t.column :created_at, :datetime
    end

    add_index :gaku_audits, [:auditable_id, :auditable_type], :name => 'auditable_index'
    add_index :gaku_audits, [:associated_id, :associated_type], :name => 'associated_index'
    add_index :gaku_audits, [:user_id, :user_type], :name => 'user_index'
    add_index :gaku_audits, :created_at
  end

  def self.down
    drop_table :gaku_audits
  end
end
