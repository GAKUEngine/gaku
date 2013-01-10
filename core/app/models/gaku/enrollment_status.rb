module Gaku
	class EnrollmentStatus < ActiveRecord::Base
		attr_accessible :name, :is_active, :immutable

    validates_presence_of :name
	end
end
