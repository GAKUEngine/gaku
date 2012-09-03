class Courses::EnrollmentsController < ApplicationController

  respond_to :js

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


  # enroll class group to course
  def enroll_class_group
    @course = Course.find(params[:id])
    @not_added_students = []
    if !params[:course][:class_group_id].blank?
      @class_group = ClassGroup.find(params[:course][:class_group_id])
      if @class_group.students.empty?
        show_flash_error_for_enroll(@course, 'Selected Class Group is empty') and return
      else
        @not_added_students = @class_group.students - @course.students
        if @not_added_students.empty? 
          show_flash_error_for_enroll(@course, 'All students are already added to the course') and return 
        end
      end
      @course.enroll_class_group(@class_group)
      respond_to do |format|
        format.js { render 'enroll_class_group' }
      end
    else
      show_flash_error_for_enroll(@course,'No Class Group selected')
    end
  end

  def show_flash_error_for_enroll(respond_with_var,message)
    respond_with(respond_with_var) do |format|
      flash.now[:error] = message
      format.html { render :nothing => true }
      format.js
    end
  end

end
