class CreateGakuAddressesTable < ActiveRecord::Migration
  def change
  	create_table :gaku_addresses do |t|
      t.string   :address1, :address2, :city
      t.string   :zipcode, :state_name, :title
      t.string   :state
      t.boolean  :is_deleted, :default => false
      t.boolean  :is_primary, :default => false


      t.references :addressable, polymorphic: true
      t.references :country
      t.references :state

      t.timestamps
    end
  end
end
