class CreateProfilesTable < ActiveRecord::Migration
  def change
  	create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.datetime :birth_date

      t.timestamps
    end
  end
end
