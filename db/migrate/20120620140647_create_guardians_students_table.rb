class CreateGuardiansStudentsTable < ActiveRecord::Migration
  def change
    create_table :guardians_students do |t|
      t.references :guardian
      t.references :student
    end 
  end
end