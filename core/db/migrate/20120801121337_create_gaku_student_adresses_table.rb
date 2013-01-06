class CreateGakuStudentAdressesTable < ActiveRecord::Migration
  def change
  	create_table :gaku_student_addresses do |t|
      t.references :student
      t.references :address
      
      t.boolean    :is_primary, :default => false

      t.timestamps
   	end
  end
end
