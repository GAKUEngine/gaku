class CreateAddressesTable < ActiveRecord::Migration
  def change
  	create_table :addresses do |t|
      t.string   :address1, :address2, :city, :zipcode, :state, :state_name

      t.timestamps
    end
  end
end
