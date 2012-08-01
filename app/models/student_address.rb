class StudentAddress < ActiveRecord::Base
	belongs_to :student
  belongs_to :address

  attr_accessible :student_id, :address_id, :is_primary
end