class CreateGakuStudentGuardiansTable < ActiveRecord::Migration
  def change
    create_table :gaku_student_guardians do |t|
      t.references :student
      t.references :guardian

      t.timestamps
    end
  end
end
