class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users  do |t|
      t.recoverable
      t.rememberable
      t.trackable
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end

end
