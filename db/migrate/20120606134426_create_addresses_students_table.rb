class CreateAddressesStudentsTable < ActiveRecord::Migration
  def change
  	 create_table :addresses_students do |t|
      t.references :student
      t.references :address
    end
  end
end
