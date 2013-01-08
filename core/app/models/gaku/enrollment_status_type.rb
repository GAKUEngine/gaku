module Gaku
	class EnrollmentStatusType < ActiveRecord::Base
		attr_accessible :name, :is_active

    validates_presence_of :name
	end
end
