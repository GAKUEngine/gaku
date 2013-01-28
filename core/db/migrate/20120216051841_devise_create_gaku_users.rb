class DeviseCreateGakuUsers < ActiveRecord::Migration
  def change
    create_table :gaku_users  do |t|

      t.boolean :admin, :default => false
      t.text    :settings
      t.string  :locale

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Database authenticatable
      t.string   :username
      t.string   :email
      t.string   :encrypted_password

      t.timestamps

    end

    add_index :gaku_users, :email,                :unique => true
    add_index :gaku_users, :username,                :unique => true
    add_index :gaku_users, :reset_password_token, :unique => true
  end
end
