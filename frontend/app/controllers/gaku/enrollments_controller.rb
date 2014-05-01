module Gaku
  class EnrollmentsController < GakuController

    respond_to :js, only: %i( new create destroy student_selection create_from_selection )

    before_action :set_enrollmentable
    before_action :set_enrollment, only: %i( destroy )
    before_action :set_students, only: %i( new )

    def student_selection
      @enrollment = @enrollmentable.enrollments.new
      @student_selection = current_user.student_selection
    end

    def new
      @enrollment = @enrollmentable.enrollments.new
    end

    def create_from_selection
      if params[:selected_students].blank?
        missing_selected_students
      else
        @enrollments, students = [], {}
        students[:enrolled], students[:not_found], students[:failed] = [], [], []

        params[:selected_students].each  do |student_id|
          student = Student.where(id: student_id).first
          if student
            enrollment = @enrollmentable.enrollments.build(student_id: student_id)
            if enrollment.save
              @enrollments << enrollment
              students[:enrolled] << student.decorate.full_name
            else
              students[:failed] << enrollment
            end
          else
            students[:not_found] << student_id
          end
        end

        set_flash_messages(students)
        set_count
      end
    end

    def create
      @enrollment = @enrollmentable.enrollments.build(enrollment_params)
      @enrollment.save
      set_count
      respond_with @enrollment
    end

    def destroy
      @enrollment.destroy
      set_count
      respond_with @enrollment
    end

    private

    def set_enrollmentable
      resource, id = request.path.split('/')[1, 2]
      @enrollmentable = resource.insert(0, 'gaku/').pluralize.classify.constantize.find(id)
      @enrollmentable_resource = @enrollmentable.class.to_s.demodulize.underscore.dasherize
    end

    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    def enrollment_params
      params.require(:enrollment).permit(attributes)
    end

    def attributes
      %i( student_id )
    end

    def set_count
      @count = @enrollmentable.students.count
    end

    def set_students
      @students = Student.all
    end

    def missing_selected_students
      set_count
      flash.now[:error] = 'No students selected!'
      redirect_to [@enrollmentable, :enrollments]
    end

    def set_flash_messages(students)
      flash_success(students[:enrolled])     if students[:enrolled].size > 0
      flash_not_found(students[:not_found])  if students[:not_found].size > 0
      flash_failure(students[:failed])       if students[:failed].size > 0
    end

    def flash_failure(enrollments)
      msg = ''
      enrollments.each do |enrollment|
        student = Gaku::Student.find(enrollment.student_id)
        msg += msg_for_failed_enrollment(student, enrollment.errors.full_messages.join(', '))
      end
      flash.now[:error] = msg.html_safe
    end

    def flash_not_found(ids)
      flash.now[:error] = "Students with ids: #{ids.join(', ')} not found".html_safe
    end

    def flash_success(students)
      msg = ''
      students.each { |student| msg += msg_for_enrollment(student) }
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
