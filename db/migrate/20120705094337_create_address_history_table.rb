class CreateAddressHistoryTable < ActiveRecord::Migration
	  def change
	  	create_table :address_histories do |t|
		  	t.string   :address1, :address2, :city, :zipcode, :state, :state_name
		  	t.references :country, :state, :faculty, :address 
  	end
  end
end
