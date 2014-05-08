module Gaku
  class Students::CourseEnrollmentsController < GakuController

    respond_to :js, only: %i( index new create destroy )

    before_action :set_student
    before_action :load_data

    def new
      @course_enrollment = @student.course_enrollments.build
      respond_with @course_enrollment
    end

    def create
      @course_enrollment = @student.course_enrollments.create(enrollment_params)
      set_count
      respond_with @course_enrollment
    end

    def index
      @course_enrollments = @student.course_enrollments
    end

    def destroy
      @course_enrollment = Gaku::Enrollment.find(params[:id])
      @course_enrollment.destroy!
      set_count
      respond_with @course_enrollment
    end

    private

    def enrollment_params
      params.require(:enrollment).permit(enrollment_attr)
    end

    def enrollment_attr
      %i( enrollmentable_id )
    end

    def set_student
      @student = Student.find(params[:student_id]).decorate
    end

    def set_count
      @count = @student.reload.courses_count
    end

    def load_data
      @courses = Gaku::Course.all
    end
  end
end
