module Gaku
  class ExtracurricularActivities::StudentsController < GakuController

    respond_to :js, only: :destroy

    def destroy
      @extracurricular_activity_enrollment = ExtracurricularActivityEnrollment.find(params[:extracurricular_activity_enrollment])
      @extracurricular_activity_enrollment.destroy
      set_count
      respond_with @extracurricular_activity_enrollment
    end

    private

    def set_count
      extracurricular_activity = ExtracurricularActivity.find(params[:extracurricular_activity_id])
      @count = extracurricular_activity.enrollments.count
    end

  end
end
