class AddStudentIdToContactsTable < ActiveRecord::Migration
  def change
  	change_table :contacts do |t|
      t.references :student
    end
  end
end