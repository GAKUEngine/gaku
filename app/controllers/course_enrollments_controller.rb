class CourseEnrollmentsController < ApplicationController

   def enroll_students
    params[:selected_students].each {|student|
      student_id = student.split("-")[1].to_i
      course_enrollment = CourseEnrollment.new(:course_id => params[:course_id], :student_id => student_id)
      # handle not saving course enrollment
      course_enrollment.save!
    }
    respond_to do |format|
      format.js { render :nothing => true }
    end
  end

end
