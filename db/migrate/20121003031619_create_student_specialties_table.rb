class CreateStudentSpecialtiesTable < ActiveRecord::Migration
  def change
  	create_table :student_specialties do |t|
  		t.references :student
  		t.references :specialty
  		t.boolean    :is_mayor
  	end
  end
end
