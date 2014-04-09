module Gaku
  class Admin::SimpleGradeTypesController < Admin::BaseController

    respond_to :js, only: %i( new create update edit destroy index )

    before_action :set_simple_grade_type, only: %i( edit update destroy )
    before_action :load_data, only: %i( new edit )

    def index
      @simple_grade_types = SimpleGradeType.all
      set_count
      respond_with @simple_grade_types
    end

    def new
      @simple_grade_type = SimpleGradeType.new
      respond_with @simple_grade_type
    end

    def create
      @simple_grade_type = SimpleGradeType.new(simple_grade_type_params)
      @simple_grade_type.save
      set_count
      flash.now[:notice] = t(:'notice.created', resource: t_resource)
      respond_with @simple_grade_type
    end

    def edit
    end

    def update
      @simple_grade_type.update(simple_grade_type_params)
      flash.now[:notice] = t(:'notice.updated', resource: t_resource)
      respond_with @simple_grade_type
    end

    def destroy
      @simple_grade_type.destroy
      set_count
      respond_with @simple_grade_type
    end

    private

    def set_simple_grade_type
      @simple_grade_type = SimpleGradeType.find(params[:id])
    end

    def simple_grade_type_params
      params.require(:simple_grade_type).permit(attributes)
    end

    def set_count
      @count = SimpleGradeType.count
    end

    def load_data
      @schools = School.all
      @grading_methods = GradingMethod.all
    end

    def attributes
      %i(name max_score passing_score grading_method_id school_id )
    end

    def t_resource
      t(:'simple_grade_type.singular')
    end
  end
end
