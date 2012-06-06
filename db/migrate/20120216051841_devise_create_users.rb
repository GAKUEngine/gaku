class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users  do |t|
      #t.recoverable
      #t.rememberable
      #t.trackable
      
      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string :email
      t.string :encrypted_password
      t.string :reset_password_token
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end
