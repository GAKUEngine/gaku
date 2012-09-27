class Admin::DisposalsController < Admin::BaseController

	def exams
		@exams = Exam.without_syllabuses
	end

	def course_groups
		@course_groups = CourseGroup.where(:is_deleted => true)
	end

end