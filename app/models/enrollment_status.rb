class EnrollmentStatus < ActiveRecord::Base
	belongs_to :enrollment_status_type
	attr_accessible :enrollment_status_type_id
end