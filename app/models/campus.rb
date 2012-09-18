class Campus < ActiveRecord::Base
	self.table_name = 'campuses'

	has_many :contacts
	belongs_to :school
	belongs_to :address

	attr_accessible :name, :school_id, :address_id

end