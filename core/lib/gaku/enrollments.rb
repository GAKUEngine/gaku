module Gaku
  module Enrollments

    def enroll_students
      params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]
      @err_enrollments = []
      @enrollments = []

      params[:selected_students].each do |student|
        student_id = student.split("-")[1].to_i
        enrollment = enrollment_class_name.constantize.new(enrollment_param => params[enrollment_param], :student_id => student_id)
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

      if params[:source] == class_name_underscored.pluralize
        @extracurricular_activity = class_name.constantize.find(params[enrollment_param])
        @count = @extracurricular_activity.extracurricular_activity_enrollments.count
        render 'gaku/extracurricular_activities/students/enroll_students'
      else
        flash.now[:notice] = notice.html_safe
        render :partial => 'gaku/shared/flash', :locals => {:flash => flash}
      end
    end

    private

    def enrollment_class_name
      "Gaku::#{controller_name.classify}"
    end

    def class_name
      "Gaku::#{controller_name.classify.split('Enrollment').first}"
    end

    def class_name_underscored
      controller_name.classify.split('Enrollment').first.underscore
    end

    def enrollment_param
      "#{controller_name.classify.split('Enrollment').first.underscore}_id"
    end



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

    def msg_for_enrollment(student)
      "<p>#{student} : <span style='color:green;'> #{t(:'success.enrolled')}</span></p>"
    end


    def msg_for_failed_enrollment(student, errors)
      "<p>#{student} : <span style='color:orange;'> #{errors}</span></p>"
    end

  end
end
