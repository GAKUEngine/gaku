class CreateGuardianAdressesTable < ActiveRecord::Migration
  def change
  	create_table :guardian_addresses do |t|
      t.references :guardian
      t.references :address
      t.boolean    :is_primary, :default => false

      t.timestamps
   	end
  end
end
