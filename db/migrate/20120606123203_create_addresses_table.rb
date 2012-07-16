class CreateAddressesTable < ActiveRecord::Migration
  def change
  	create_table :addresses do |t|
      t.string   :address1, :address2, :city, :zipcode, :state, :state_name
      t.boolean :past, :default => false

      t.timestamps
    end
  end
end
