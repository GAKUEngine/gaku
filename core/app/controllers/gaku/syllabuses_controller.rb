module Gaku
  class SyllabusesController < GakuController

    respond_to :js,   only: %i( new create destroy recovery )
    respond_to :html, only: %i( index edit update soft_delete show_deleted )

    before_action :set_syllabus, only: %i( edit update soft_delete )
    before_action :set_unscoped_syllabus, only: %i( show_deleted destroy recovery )
    before_action :set_departments, only: %i( new edit )

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
      respond_with @syllabus, location: [:edit, @syllabus]
    end

    def soft_delete
      @syllabus.soft_delete
      respond_with @syllabus, location: syllabuses_path
    end

    def recovery
      @syllabus.recover
      respond_with @syllabus
    end

    def show_deleted
      render :show
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

    def set_unscoped_syllabus
      @syllabus = Syllabus.unscoped.find(params[:id])
    end

    def set_departments
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
