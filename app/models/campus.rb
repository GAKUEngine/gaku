class Campus < ActiveRecord::Base
	self.table_name = 'campuses'

	belongs_to :school

end