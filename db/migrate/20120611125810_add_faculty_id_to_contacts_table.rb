class AddFacultyIdToContactsTable < ActiveRecord::Migration
  def change
    change_table :contacts do |t|
      t.references :faculty
    end
  end
end
