module Gaku
  class Students::SimpleGradesController < GakuController

    inherit_resources
    belongs_to :student
    respond_to :js, :html, :json

    before_filter :student
    before_filter :count, :only => [:index, :create, :destroy, :update]
    before_filter :simple_grades, :only => :update


     def index
      @simple_grades = @student.simple_grades
      respond_with @simple_grades
    end

    private

    def student
      @student = Student.find(params[:student_id])
    end

    def count
      @count = SimpleGrade.count
    end

    def simple_grades
      @simple_grades = @student.simple_grades
    end


  end
end