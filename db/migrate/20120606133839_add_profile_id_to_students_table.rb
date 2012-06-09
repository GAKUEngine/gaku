class AddProfileIdToStudentsTable < ActiveRecord::Migration
  def change
  	change_table :students do |t|
      t.references :profile
    end
  end
end
