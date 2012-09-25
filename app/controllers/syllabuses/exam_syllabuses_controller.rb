class Syllabuses::ExamSyllabusesController < ApplicationController

	def destroy
		@exam_syllabus = ExamSyllabus.find(params[:id])
		@exam_syllabus.destroy
		
		respond_to do |format|
			format.js { render :nothing => true }
		end
	end

end