# == Schema Information
#
# Table name: enrollment_status_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  is_active  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EnrollmentStatusType < ActiveRecord::Base 
	attr_accessible :name, :is_active
end
