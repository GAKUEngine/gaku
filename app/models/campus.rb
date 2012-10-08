# == Schema Information
#
# Table name: campuses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  school_id  :integer
#  address_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Campus < ActiveRecord::Base
	self.table_name = 'campuses'

	has_many :contacts
	belongs_to :school
	belongs_to :address

	attr_accessible :name, :school_id, :address_id, :is_master

end
