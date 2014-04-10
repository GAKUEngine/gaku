module Gaku
  class Students::CourseEnrollmentsController < GakuController

    respond_to :js, only: %i( new create destroy index )

    before_action :set_student

    def index
      @course_enrollments = @student.course_enrollments
    end

    def new
      set_courses
      @course_enrollment = CourseEnrollment.new
      respond_with @course_enrollment
    end

    def create
      @course_enrollment = CourseEnrollment.new(course_enrollment_params)
      if @course_enrollment.save
        set_count
        respond_with @course_enrollment
      else
        set_count
        render :error
      end
    end

    def destroy
      @course_enrollment = CourseEnrollment.find(params[:id])
      @course_enrollment.destroy
      set_count
      respond_with @course_enrollment
    end

    private

    def course_enrollment_params
      params.require(:course_enrollment).permit([:course_id, :student_id])
    end

    def set_student
      @student = Student.find(params[:student_id])
    end

    def set_courses
      @courses = Course.includes(:syllabus).decorate
    end

    def set_count
      @count = @student.reload.courses_count
    end

  end
end
