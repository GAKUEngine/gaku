module Gaku
	module Admin
		class DisposalsController < Admin::BaseController
			helper_method :sort_column, :sort_direction

			def students
				@students = Student.where(:is_deleted => true)
			end


			def exams
				@exams = Exam.without_syllabuses
			end

			def course_groups
				@course_groups = CourseGroup.where(:is_deleted => true).order(sort_column + " " + sort_direction)
			end

			def attachments
				@attachments = Attachment.where(:is_deleted => true).order(sort_column + " " + sort_direction)
			end

			def student_addresses
				@student_addresses = StudentAddress.where(:is_deleted => true)
			end

			private

		  def sort_column
	      Student.column_names.include?(params[:sort]) ? params[:sort] : "name"
	    end

	    def sort_direction
	      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
	    end

		end
	end
end
