class CreateAddressesGuardiansTable < ActiveRecord::Migration
  def change
    create_table :addresses_guardians do |t|
      t.references :address
      t.references :guardian
    end 
  end
end
