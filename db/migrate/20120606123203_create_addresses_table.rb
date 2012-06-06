class CreateAddressesTable < ActiveRecord::Migration
  def change
  	create_table :addresses do |t|
      t.string   :first_name, :last_name, :address1, :address2, :city,
                 :zipcode, :state, :state_name

      t.timestamps
    end
  end
end
