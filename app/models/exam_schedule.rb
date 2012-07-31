class ExamSchedule < ActiveRecord::Base
	belongs_to :exam_portion
	belongs_to :schedule
	belongs_to :course
end