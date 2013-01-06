class CreateGakuStudentSpecialtiesTable < ActiveRecord::Migration
  def change
  	create_table :gaku_student_specialties do |t|
  		t.references :student
  		t.references :specialty

  		t.boolean    :is_mayor, :default => true
      
      t.timestamps
  	end
  end
end
