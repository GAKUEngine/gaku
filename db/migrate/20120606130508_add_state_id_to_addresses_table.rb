class AddStateIdToAddressesTable < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.references :state
    end
  end
end
