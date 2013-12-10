[module Gaku
  class Students::StudentAchievementsController < GakuController

    respond_to :js, only: %i( new create edit update destroy index )

    before_action :set_student
    before_action :set_student_achievement, only: %i( edit update destroy )
    before_action :set_achievements,        only: %i( new edit )

    def new
      @student_achievement = StudentAchievement.new
      respond_with @student_achievement
    end

    def create
      @student_achievement = @student.student_achievements.create!(student_achievement_params)
      set_count
      respond_with @student_achievement
    end

    def edit
    end

    def update
      @student_achievement.update(student_achievement_params)
      respond_with @student_achievement
    end

    def destroy
      @student_achievement.destroy
      set_count
      respond_with @student_achievement
    end

    def index
      @student_achievements = @student.student_achievements
      set_count
      respond_with @student_achievements
    end

    private

    def student_achievement_params
      params.require(:student_achievement).permit(:achievement_id)
    end

    def set_achievements
      @achievements = Achievement.all
    end

    def set_student
      @student = Student.find(params[:student_id]).decorate
    end

    def set_student_achievement
      @student_achievement = StudentAchievement.find(params[:id])
    end

    def set_count
      @count = @student.student_achievements.count
    end

  end
end
]
