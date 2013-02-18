module Gaku
  class Students::SimpleGradesController < GakuController

    #skip_load_and_authorize_resource :only => :index
    skip_authorization_check

    #load_and_authorize_resource :student, :class => Gaku::Student
    #load_and_authorize_resource :simple_grade, :through => :student, :class => Gaku::SimpleGrade

    inherit_resources
    belongs_to :student
    respond_to :js, :html, :json

    before_filter :student
    before_filter :count, :only => [:index, :create, :destroy, :update]
    before_filter :simple_grades, :only => :update


    protected

    def collection
      @simple_grades ||= end_of_association_chain.accessible_by(current_ability)
    end

    def begin_of_association_chain
      @student
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
