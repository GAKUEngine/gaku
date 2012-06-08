class AddGuardianIdToContactsTable < ActiveRecord::Migration
  def change
  	change_table :contacts do |t|
      t.references :guardian
  	end
  end
end
