class Admin::DisposalsController < Admin::BaseController
	helper_method :sort_column, :sort_direction

	def exams
		@exams = Exam.without_syllabuses
	end

	def course_groups
		@course_groups = CourseGroup.where(:is_deleted => true).order(sort_column + " " + sort_direction)
	end

	 def sort_column
      Student.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

end