class CreateGuardiansStudentsTable < ActiveRecord::Migration
  def change
    create_table :gaku_guardians_students do |t|
      t.references :guardian
      t.references :student
    end 
  end
end