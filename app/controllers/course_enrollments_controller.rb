class CourseEnrollmentsController < ApplicationController

  inherit_resources

  actions :show, :new, :create, :update, :edit, :destroy

  # creating course_enrollment from courses/show
  def enroll_student
    @course_enrollment = CourseEnrollment.new(params[:course_enrollment])
    @course = Course.find(params[:course_enrollment][:course_id])
    if @course_enrollment.save
      respond_with(@course_enrollment) do |format|
        format.js { render 'enroll_student' }
      end
    else
      @errors = @course_enrollment.errors
      respond_with(@course_enrollment) do |format|
        format.js { render 'error' }
      end
    end

  end


end
