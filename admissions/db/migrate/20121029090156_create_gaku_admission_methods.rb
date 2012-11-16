class CreateGakuAdmissionMethods < ActiveRecord::Migration
  def change 
  	create_table :gaku_admission_methods do |t|
      t.string      :name
      t.references  :admission_period

      t.timestamps
  	end
  end
end
