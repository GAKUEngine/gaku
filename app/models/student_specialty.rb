class StudentSpecialty < ActiveRecord::Base
	belongs_to :specialty
  belongs_to :student

  attr_accessible :student_id, :specialty_id , :is_mayor
end