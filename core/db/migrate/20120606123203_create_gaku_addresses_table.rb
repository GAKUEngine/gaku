class CreateGakuAddressesTable < ActiveRecord::Migration
  def change
  	create_table :gaku_addresses do |t|
      t.string   :address1, :address2, :city
      t.string   :zipcode, :state_name, :title
#      t.string   :encrypted_address1, :encrypted_address2, :encrypted_city
#      t.string   :encrypted_zipcode, :encrypted_state_name, :encrypted_title
      t.string   :state
      t.boolean :past, :default => false

      t.references :country
      t.references :state
      t.references :faculty
      t.references :campus

      t.timestamps
    end
  end
end
