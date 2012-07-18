class CourseEnrollmentsController < ApplicationController

  inherit_resources

  actions :show, :new, :create, :update, :edit, :destroy
  
  # creating course_enrollment form students/show
  def create
  raise  request.to_json
    super do |format|
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
