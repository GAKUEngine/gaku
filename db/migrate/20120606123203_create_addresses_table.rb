class CreateAddressesTable < ActiveRecord::Migration
  def change
  	create_table :addresses do |t|
      t.string   :address1, :address2, :city, :zipcode, :state, :state_name, :title
      t.boolean :past, :default => false
      t.boolean :is_primary, :default => false

      t.references :country
      t.references :state
      t.references :faculty

      t.timestamps
    end
  end
end
