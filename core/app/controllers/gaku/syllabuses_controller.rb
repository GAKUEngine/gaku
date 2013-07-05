module Gaku
  class SyllabusesController < GakuController

    load_and_authorize_resource class: Gaku::Syllabus

    before_filter :before_show,  only: :show
    before_filter :count,        only: [:create, :destroy, :index]

    inherit_resources
    respond_to :js, :html

    protected

    def resource_params
      return [] if request.get?
      [params.require(:syllabus).permit(syllabus_attr)]
    end

    private

    def syllabus_attr
      %i(name code credits description)
    end

    def syllabus
      @syllabus = Syllabus.find(params[:id])
    end

    def grading_methods
      @grading_methods = GradingMethod.all
    end

    def before_show
      syllabus
      @notable = @syllabus
      @notable_resource = get_resource_name @notable
      grading_methods
    end

    def count
      @count = Syllabus.count
    end

  end
end
