class Attendance < ActiveRecord::Base
	attr_accessible :reason, :description

	belongs_to :attendancable, :polymorphic => true
	belongs_to :student
end