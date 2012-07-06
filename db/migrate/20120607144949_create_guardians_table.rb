class CreateGuardiansTable < ActiveRecord::Migration
  def change
    create_table :guardians do |t|
      t.string   :relationship
    end 
  end
end
