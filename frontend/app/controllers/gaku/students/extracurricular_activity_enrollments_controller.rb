module Gaku
  class Students::ExtracurricularActivityEnrollmentsController < GakuController

    respond_to :js, only: %i( index new create destroy )

    before_action :set_student
    before_action :load_data

    def new
      @extracurricular_activity_enrollment = @student.extracurricular_activity_enrollments.build
      respond_with @extracurricular_activity_enrollment
    end

    def create
      @extracurricular_activity_enrollment = @student.extracurricular_activity_enrollments.create(enrollment_params)
      set_count
      respond_with @extracurricular_activity_enrollment
    end

    def index
      @extracurricular_activity_enrollments = @student.extracurricular_activity_enrollments
    end

    def destroy
      @extracurricular_activity_enrollment = Gaku::Enrollment.find(params[:id])
      @extracurricular_activity_enrollment.destroy!
      set_count
      respond_with @extracurricular_activity_enrollment
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
      @count = @student.reload.extracurricular_activities_count
    end

    def load_data
      @extracurricular_activities = Gaku::ExtracurricularActivity.all
    end
  end
end
