module Gaku
  class Students::StudentAchievementsController < GakuController

    #load_and_authorize_resource :student, :class => Gaku::Student
    #load_and_authorize_resource :achievement, :through => :student, :class => Gaku::Achievement
    skip_authorization_check

    inherit_resources
    belongs_to :student
    respond_to :js, :html, :json

    before_filter :student
    before_filter :student_achievements, :only => [:update]
    before_filter :count, :only => [:index, :create, :destroy]

    def index
      @student_achievements = @student.student_achievements
      respond_with @student_achievements
    end

    private

    def student
      @student = Student.find(params[:student_id])
    end

    def student_achievements
      @student_achievements = @student.student_achievements
    end

    def count
      @count = @student.student_achievements.count
    end

  end
end
