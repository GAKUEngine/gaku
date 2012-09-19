class CreateGuardiansTable < ActiveRecord::Migration
  def change
    create_table :guardians do |t|
      t.string   :name
      t.string   :surname
      t.string   :name_reading
      t.string   :surname_reading
      t.string   :relationship
#      t.string   :encrypted_name
#      t.string   :encrypted_surname
#      t.string   :encrypted_name_reading
#      t.string   :encrypted_surname_reading
#      t.string   :encrypted_relationship

      t.references :user

      t.timestamps
    end 
  end
end
