module Gaku
  module EnrollmentsController

    include Core::ClassNameDetector

    def enroll_students
      params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]
      @err_enrollments = []
      @enrollments = []

      params[:selected_students].each do |student|
        student_id = student.split("-")[1].to_i
        enrollment = class_name.constantize.new(enrollment_param => params[enrollment_param], :student_id => student_id)
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

      if params[:source] == class_name_underscored_plural
        @resource = class_name_minus_enrollment.constantize.find(params[enrollment_param])
        @count = @resource.enrollments.count
        if class_name_underscored_plural == 'courses'
          render "gaku/#{class_name_underscored_plural}/enrollments/students/enroll_students"
        else
          render "gaku/#{class_name_underscored_plural}/students/enroll_students"
        end
      #else
      #  flash.now[:notice] = notice.html_safe
      #  render :partial => 'gaku/shared/flash', :locals => {:flash => flash}
      end
    end


    def autocomplete_filtered_students
      @enrolled_students = class_name.constantize.where(enrollment_param => params[enrollment_param]).pluck(:student_id)

      if @enrolled_students.blank?
        @students = Student.where('(surname || " " || name LIKE ?) OR (name || " " || surname LIKE ?)', "%#{params[:term]}%", "%#{params[:term]}%")
      else
        @students = Student.where('id not in (?)) and ((surname || " " || name LIKE ?) OR (name || " " || surname LIKE ?)', @enrolled_students ,"%#{params[:term]}%", "%#{params[:term]}%" )
      end

      render json: @students.as_json
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

    def msg_for_enrollment(student)
      "<p>#{student} : <span style='color:green;'> #{t(:'success.enrolled')}</span></p>"
    end


    def msg_for_failed_enrollment(student, errors)
      "<p>#{student} : <span style='color:orange;'> #{errors}</span></p>"
    end

  end
end
