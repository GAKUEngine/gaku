class CourseEnrollmentsController < ApplicationController

   def enroll_students
    @err_enrollments = []
    @enrollments = []
    params[:selected_students].each {|student|
      student_id = student.split("-")[1].to_i
      course_enrollment = CourseEnrollment.new(:course_id => params[:course_id], :student_id => student_id)
      if  course_enrollment.save
        @enrollments << course_enrollment
      else
        @err_enrollments << course_enrollment
      end
    }
    notice = ""
    if !@enrollments.empty?
      
      @enrollments.each {|enrollment|
        student = Student.find(enrollment.student_id)
        notice+= "<p>" + student.name + " " + student.surname + ": " + "<span style='color:green;'>Successfully enrolled.</span>" + "</p>"
      }
    end
    if !@err_enrollments.empty?
      
      @err_enrollments.each {|enrollment|
        student = Student.find(enrollment.student_id)
        notice+= "<p>" + student.name + " " + student.surname + ": <span style='color:orange;'>" + enrollment.errors.full_messages.join(", ") + "</span></p>"
      }
    end
    render 'shared/notice', :locals => {:notice => notice}
  end

end
