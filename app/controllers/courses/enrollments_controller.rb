class Courses::EnrollmentsController < ApplicationController

  respond_to :js

  def enroll_student
    @course_enrollment = CourseEnrollment.new(params[:course_enrollment])
    @course = Course.find(params[:course_enrollment][:course_id])
    if @course_enrollment.save
      respond_with(@course_enrollment) do |format|
        format.js { render 'courses/enrollments/students/enroll' }
      end
    else
      @errors = @course_enrollment.errors
      respond_with(@course_enrollment) do |format|
        format.js { render 'error' }
      end
    end
  end


  def enroll_class_group
    @course = Course.find(params[:id])
    @not_added_students = []
    if !params[:course][:class_group_id].blank?
      @class_group = ClassGroup.find(params[:course][:class_group_id])
      if @class_group.students.empty?
        show_flash_error_for_enroll(@course, 'Selected Class Group is empty') and return
      else
        @not_added_students = @class_group.students - @course.students
        logger.debug "CG: #{@class_group.students.inspect}"
        logger.debug "C: #{@course.students.inspect}"
        if @not_added_students.empty? 
          show_flash_error_for_enroll(@course, 'All students are already added to the course') and return 
        end
      end
      @course.enroll_class_group(@class_group)
      respond_to do |format|
        format.js { render 'courses/enrollments/class_groups/enroll' }
      end
    else
      show_flash_error_for_enroll(@course,'No Class Group selected')
    end
  end


  def show_flash_error_for_enroll(respond_with_var,message)
    respond_with(respond_with_var) do |format|
      flash.now[:notice] = message
      format.html { render :nothing => true }
      format.js { render 'courses/enrollments/class_groups/enroll'}
    end
  end

end
