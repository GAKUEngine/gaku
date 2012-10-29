class CreateGakuAdmissionMethods < ActiveRecord::Migration
  def change 
  	create_table :gaku_admission_methods do |t|
      t.string :name
  	end
  end
end
