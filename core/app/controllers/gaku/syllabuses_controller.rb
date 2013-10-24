module Gaku
  class SyllabusesController < GakuController

    #load_and_authorize_resource class: Gaku::Syllabus

    respond_to :js,   only: %i( new create edit update destroy )
    respond_to :html, only: %i( index edit show update )

    before_action :set_syllabus, only: %i( edit update destroy )
    before_action :load_data, only: %i( new edit )

    def new
      @syllabus = Syllabus.new
      respond_with @syllabus
    end

    def create
      @syllabus = Syllabus.new(syllabus_params)
      @syllabus.save
      set_count
      respond_with @syllabus
    end

    def index
      @syllabuses = Syllabus.all
      set_count
      respond_with @syllabuses
    end

    def edit
      set_grading_methods
      set_notable
    end

    def update
      @syllabus.update(syllabus_params)
      respond_with(@syllabus) do |format|
        format.js { render }
        format.html { redirect_to [:edit, @syllabus] }
      end
    end

    def destroy
      @syllabus.destroy
      set_count
      respond_with @syllabus
    end

    private

    def syllabus_params
      params.require(:syllabus).permit(syllabus_attr)
    end

    def syllabus_attr
      %i( name code credits description department_id )
    end

    def set_syllabus
      @syllabus = Syllabus.find(params[:id])
    end

    def load_data
      @departments = Department.all
    end

    def set_grading_methods
      @grading_methods = GradingMethod.all
    end

    def set_notable
      @notable = @syllabus
      @notable_resource = get_resource_name @notable
    end

    def set_count
      @count = Syllabus.count
    end

  end
end
