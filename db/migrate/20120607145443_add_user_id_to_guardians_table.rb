class AddUserIdToGuardiansTable < ActiveRecord::Migration
  def change
  	change_table :guardians do |t|
      t.references :user
  	end
  end
end
