module Gaku
  ExtracurricularActivitiesController.class_eval do

    def recovery
      @extracurricular_activity = ExtracurricularActivity.deleted.find(params[:id])
      @extracurricular_activity.recover
      respond_with @extracurricular_activity
    end

    def soft_delete
      @extracurricular_activity = ExtracurricularActivity.find(params[:id])
      @extracurricular_activity.soft_delete
      respond_with @extracurricular_activity, location: extracurricular_activities_path
    end

  end
end
