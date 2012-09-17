class Campus < ActiveRecord::Base
	self.table_name = 'campuses'

	has_many :contacts
	belongs_to :school

end