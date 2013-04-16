module Gaku
  class ExtracurricularActivitiesController < GakuController

    load_and_authorize_resource :class =>  Gaku::ExtracurricularActivity

    include StudentChooserController

    inherit_resources
    respond_to :js, :html

    before_filter :count, :only => [:create, :destroy, :index]

    protected

    def resource
      @extracurricular_activity = ExtracurricularActivity.includes(includes).find(params[:id])
    end

    def collection
      @search = ExtracurricularActivity.search(params[:q])
      results = @search.result(:distinct => true)

      @extracurricular_activities = results.page(params[:page]).per(Preset.default_per_page)
    end

    def includes
      #:student
    end

    private

    def count
      @count = ExtracurricularActivity.count
    end

  end
end
