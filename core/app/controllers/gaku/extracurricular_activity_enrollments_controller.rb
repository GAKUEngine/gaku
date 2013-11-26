module Gaku
  class ExtracurricularActivityEnrollmentsController < GakuController

    include EnrollmentsController

     def destroy
      @extracurricular_activity_enrollment = ExtracurricularActivityEnrollment.find(params[:extracurricular_activity_enrollment])
      @extracurricular_activity = ExtracurricularActivity.find(@extracurricular_activity_enrollment.extracurricular_activity_id)
      @extracurricular_activity_enrollment.destroy
      respond_with(@extracurricular_activity_enrollment) do |format|
        format.js { render 'destroy' }
      end
    end

  end
end
