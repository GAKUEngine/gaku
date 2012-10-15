# == Schema Information
#
# Table name: enrollment_statuses
#
#  id                        :integer          not null, primary key
#  enrollment_status_type_id :integer
#  student_id                :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class EnrollmentStatus < ActiveRecord::Base
	belongs_to :enrollment_status_type
	belongs_to :student

	audited :associated_with => :student
	
	attr_accessible :enrollment_status_type_id, :student_id
end
