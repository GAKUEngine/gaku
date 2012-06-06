class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      #t.database_authenticatable
      #t.recoverable
      #t.rememberable
      #t.trackable
      t.string :email
      t.string :encrypted_password
      t.string :reset_password_token
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end
