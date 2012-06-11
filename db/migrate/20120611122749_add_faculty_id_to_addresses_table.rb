class AddFacultyIdToAddressesTable < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.references :faculty
    end
  end
end
