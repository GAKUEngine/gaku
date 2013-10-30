module Gaku
  class ExtracurricularActivitiesController < GakuController

    #load_and_authorize_resource class: Gaku::ExtracurricularActivity

    include StudentChooserController

    respond_to :js,   only: %i( new create edit update destroy )
    respond_to :html, only: %i( index edit update show )

    before_action :set_extracurricular_activity, only: %i( edit show update destroy student_chooser )

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
      respond_with(@extracurricular_activity) do |format|
        format.js { render }
        format.html { redirect_to [:edit, @extracurricular_activity] }
      end
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
    end

    def set_count
      @count = ExtracurricularActivity.count
    end

  end
end
