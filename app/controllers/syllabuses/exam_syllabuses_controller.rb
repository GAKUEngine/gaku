class Syllabuses::ExamSyllabusesController < ApplicationController

	def destroy
		@syllabus = Syllabus.find(params[:syllabus_id])
		@exam_syllabus = ExamSyllabus.find(params[:id])
		@exam_syllabus.destroy
		
		respond_to do |format|
			format.js { render 'destroy' }
		end
	end

	def create
		@syllabus = Syllabus.find(params[:syllabus_id])
		@exam_syllabus = @syllabus.exam_syllabuses.build(params[:exam_syllabus])
		@exam_syllabus.save
		
		respond_to do |format|
			flash.now[:notice] = 'Exam added to Syllabus'
			format.js { render 'create' }
		end
	end

end