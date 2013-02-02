module Gaku
  class ExtracurricularActivityEnrollmentsController < GakuController

    include EnrollmentHelper

    def enroll_students
      params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]
      @err_enrollments = []
      @enrollments = []

      params[:selected_students].each do |student|
        student_id = student.split("-")[1].to_i
        enrollment = ExtracurricularActivityEnrollment.new(:extracurricular_activity_id => params[:extracurricular_activity_id], :student_id => student_id)
        if  enrollment.save
          @enrollments << enrollment
        else
          @err_enrollments << enrollment
        end
      end


      if @enrollments.empty?
        flash_failure @err_enrollments
      else
        flash_success @enrollments
      end

      if params[:source] == "extracurricular_activities"
        @extracurricular_activity = ExtracurricularActivity.find(params[:extracurricular_activity_id])
        @count = @extracurricular_activity.extracurricular_activity_enrollments.count
        render 'gaku/extracurricular_activities/students/enroll_students'
      else
        flash.now[:notice] = notice.html_safe
        render :partial => 'gaku/shared/flash', :locals => {:flash => flash}
      end
    end


    def autocomplete_filtered_students
      @enrolled_students = ExtracurricularActivityEnrollment.where(:extracurricular_activity_id => params[:extracurricular_activity_id]).pluck(:student_id)

      if @enrolled_students.blank?
        @students = Student.includes([:addresses, :extracurricular_activities, :extracurricular_activity_enrollments])
                           .where('(surname || " " || name LIKE ?) OR (name || " " || surname LIKE ?)', "%#{params[:term]}%", "%#{params[:term]}%")
      else
        @students = Student.includes([:addresses, :extracurricular_activities, :extracurricular_activity_enrollments])
                          .where('id not in (?)) and ((surname || " " || name LIKE ?) OR (name || " " || surname LIKE ?)',@class_group_enrolled_students ,"%#{params[:term]}%", "%#{params[:term]}%" )
      end

      render json: @students.as_json(:methods => [:address_widget])
    end


    private

    def flash_failure(enrollments)
      msg = ""
      enrollments.each do |enrollment|
        student = Student.find(enrollment.student_id)
        msg += msg_for_failed_enrollment(student, enrollment.errors.full_messages.join(", "))
      end
      flash.now[:error] = msg.html_safe
    end


    def flash_success(enrollments)
      msg = ""
      enrollments.each do |enrollment|
        student = Student.find(enrollment.student_id)
        msg += msg_for_enrollment(student)
      end
      flash.now[:success] = msg.html_safe
    end

  end
end
