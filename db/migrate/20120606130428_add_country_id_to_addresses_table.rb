class AddCountryIdToAddressesTable < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.references :country
    end
  end
end
