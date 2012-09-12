class CreateAddressesTable < ActiveRecord::Migration
  def change
  	create_table :addresses do |t|
      t.string   :encrypted_address1, :encrypted_address2, :encrypted_city
      t.string   :encrypted_zipcode, :encrypted_state_name, :encrypted_title
      t.string   :state
      t.boolean :past, :default => false
      
      t.references :country
      t.references :state
      t.references :faculty

      t.timestamps
    end
  end
end
