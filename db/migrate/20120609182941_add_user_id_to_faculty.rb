class AddUserIdToFaculty < ActiveRecord::Migration
  def change
    change_table :faculties do |t|
      t.references :users
    end
  end
end
