class ExamSyllabus < ActiveRecord::Base
	belongs_to :syllabus
	belongs_to :exam
end