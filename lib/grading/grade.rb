class Grade
	# rails config for default grading method
	GRADE_METHOD = "japanese_hs_standard"

	def initialize(exam_portion)
		@exam_portion = exam_portion
		#checking grading system
		# best use will be 'case statement'
		if GRADE_METHOD == "japanese_hs_standard"
			@grade = JapaneseHsStandard.new
		end
	end

	def grade_portion
		@grade.grade_portion(@exam_portion)
	end
end