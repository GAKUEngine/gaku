# == Schema Information
#
# Table name: exam_schedules
#
#  id              :integer          not null, primary key
#  exam_portion_id :integer
#  schedule_id     :integer
#  course_id       :integer
#

class ExamSchedule < ActiveRecord::Base
	belongs_to :exam_portion
	belongs_to :schedule
	belongs_to :course
end
