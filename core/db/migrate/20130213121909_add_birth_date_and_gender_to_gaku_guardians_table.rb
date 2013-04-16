class AddBirthDateAndGenderToGakuGuardiansTable < ActiveRecord::Migration
  def change
    change_table :gaku_guardians do |t|
      t.boolean  :gender
      t.date     :birth_date
    end
  end
end
