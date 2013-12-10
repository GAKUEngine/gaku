module Gaku
  class Students::SimpleGradesController < GakuController

    respond_to :js, only: %i( new create edit update index destroy )

    before_action :student
    before_action :set_schools, only: %i( new edit )
    before_action :set_simple_grade, only: %i( edit update destroy )

    def new
      @simple_grade = SimpleGrade.new
      respond_with @simple_grade
    end

    def create
      @simple_grade = SimpleGrade.new(simple_grade_params)
      @student.simple_grades << @simple_grade
      set_count
      respond_with @simple_grade
    end

    def edit
    end

    def update
      @simple_grade.update(simple_grade_params)
      respond_with @simple_grade
    end

    def index
      @simple_grades = @student.simple_grades
      set_count
      respond_with @simple_grades
    end

    def destroy
      @simple_grade.destroy
      set_count
      respond_with @simple_grade
    end

    private

    def simple_grade_params
      params.require(:simple_grade).permit(simple_grade_attr)
    end

    def simple_grade_attr
      %i( name grade school_id )
    end

    def set_schools
      @schools = School.all
    end

    def student
      @student ||= Student.find(params[:student_id]).decorate
    end

    def set_count
      @count = @student.simple_grades.count
    end

    def set_simple_grade
      @simple_grade = SimpleGrade.find(params[:id])
    end

  end
end
