class Admin::DisposalsController < Admin::BaseController

	def exams
		@exams = Exam.without_syllabuses
	end

end