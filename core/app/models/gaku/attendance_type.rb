module Gaku
	class AttendanceType < ActiveRecord::Base

		has_many :attendances

		attr_accessible :name, :color_code, :counted_absent, :disable_credit, :credit_rate, :auto_credit

    validates_presence_of :name

	end
end