class AddDisabledAttributesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :gaku_users, :disabled_until, :date
    add_column :gaku_users, :disabled, :boolean, default: false
  end
end
