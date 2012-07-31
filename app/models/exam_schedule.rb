class ExamSchedule < ActiveRecord::Base
	belongs_to :exam_portion
	belongs_to :schedule
end