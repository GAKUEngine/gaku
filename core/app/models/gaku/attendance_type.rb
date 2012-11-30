module Gaku
	class AttendanceType < ActiveRecord::Base

		has_many :attendances

		attr_accessible :name, :color_code, :counted_absent, :disable_credit, :credit_rate, :auto_credit

	end
end