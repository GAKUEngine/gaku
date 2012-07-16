class AssignmentScore < ActiveRecord::Base
	belongs_to :student
	attr_accessible :student_id
end