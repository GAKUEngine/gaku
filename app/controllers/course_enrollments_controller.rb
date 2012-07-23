class CourseEnrollmentsController < ApplicationController

  inherit_resources

  actions :show, :new, :create, :update, :edit, :destroy
  
  # creating course_enrollment form students/show
  def create
    super do |format|
      @student = Student.find(params[:course_enrollment][:student_id])      
      format.js {render 'create'}
    end  
  end

  # creating course_enrollment from courses/show
  def enroll_student
 		@course_enrollment = CourseEnrollment.new(params[:course_enrollment])
 		# handle not saving course enrollment
 		if @course_enrollment.save!
 			respond_to do |format|
 				format.js { render 'enroll_student'}
 			end
 		end
  end

end
