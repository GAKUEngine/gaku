class CreateGakuAdmissionsTable < ActiveRecord::Migration
  def change
    create_table :gaku_admissions do |t|
      t.boolean     :admitted
      t.references  :student
    end
  end
end
