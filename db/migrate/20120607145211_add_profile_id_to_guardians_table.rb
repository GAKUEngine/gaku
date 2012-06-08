class AddProfileIdToGuardiansTable < ActiveRecord::Migration
  def change
  	change_table :guardians do |t|
      t.references :profile
    end
  end
end
