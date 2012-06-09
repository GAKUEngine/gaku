class AddUserIdToStudentsTable < ActiveRecord::Migration
  def change
  	change_table :students do |t|
      t.references :user
    end
  end
end
