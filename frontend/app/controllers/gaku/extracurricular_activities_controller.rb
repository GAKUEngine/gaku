module Gaku
  class ExtracurricularActivitiesController < GakuController

    include StudentChooserController

    # respond_to :js,   only: %i( new create destroy recovery student_chooser )
    # respond_to :html, only: %i( index edit update show show_deleted soft_delete )
    respond_to :html, :js

    before_action :set_extracurricular_activity, only: %i( edit show update student_chooser destroy )

    def destroy
      @extracurricular_activity.destroy
      set_count
      respond_with @extracurricular_activity
    end

    def new
      @extracurricular_activity = ExtracurricularActivity.new
      respond_with @extracurricular_activity
    end

    def create
      @extracurricular_activity = ExtracurricularActivity.new(extracurricular_activity_params)
      @extracurricular_activity.save
      set_count
      respond_with @extracurricular_activity
    end

    def edit
    end

    def show
    end

    def update
      @extracurricular_activity.update(extracurricular_activity_params)
      respond_with @extracurricular_activity, location: [:edit, @extracurricular_activity]
    end

    def index
      @search = ExtracurricularActivity.search(params[:q])
      results = @search.result(distinct: true)
      @extracurricular_activities = results.page(params[:page])
      set_count
      respond_with @extracurricular_activities
    end

    private

    def extracurricular_activity_params
      params.require(:extracurricular_activity).permit(attributes)
    end

    def attributes
      %i( name )
    end

    def set_extracurricular_activity
      @extracurricular_activity = ExtracurricularActivity.find(params[:id])
      set_enrollmentable
    end

    def set_enrollmentable
      @enrollmentable = @extracurricular_activity
      @enrollmentable_resource = @enrollmentable.class.to_s.demodulize.underscore.dasherize
    end

    def set_count
      @count = ExtracurricularActivity.count
    end

  end
end
