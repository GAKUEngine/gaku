module Gaku
	class AttendanceType < ActiveRecord::Base
		has_many :attendances

    validates :name, :presence => true, :uniqueness => true

		attr_accessible :name, :color_code, :counted_absent, :disable_credit, :credit_rate, :auto_credit
    
	end
end
