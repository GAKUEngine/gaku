class CreateGakuUserRolesTable < ActiveRecord::Migration
  def change
    create_table :gaku_user_roles do |t|
      t.references :user
      t.references :role

      t.timestamps
    end
  end
end
