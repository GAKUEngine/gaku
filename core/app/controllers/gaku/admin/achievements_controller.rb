module Gaku
  class Admin::AchievementsController < Admin::BaseController

    #load_and_authorize_resource class: Achievement

    respond_to :js,   only: %i( new edit destroy )
    respond_to :html, only: %i( index create update )

    before_action :set_achievement, only: %i( edit update destroy )

    def index
      @achievements = Achievement.all
      @count = Achievement.count
      respond_with @achievements
    end

    def new
      @achievement = Achievement.new
      respond_with @achievement
    end

    def create
      @achievement = Achievement.new(achievement_params)
      @achievement.save
      @count = Achievement.count
      flash[:notice] = t(:'notice.created', resource: t_resource)
      respond_with [:admin, :achievements]
    end

    def edit
    end

    def update
      @achievement.update(achievement_params)
      flash[:notice] = t(:'notice.updated', resource: t_resource)
      respond_with [:admin, :achievements]
    end

    def destroy
      @achievement.destroy
      @count = Achievement.count
      respond_with @achievement
    end

    private

    def set_achievement
      @achievement = Achievement.find(params[:id])
    end

    def achievement_params
      params.require(:achievement).permit(attributes)
    end

    def attributes
      %i(name description authority badge external_school_record)
    end

    def t_resource
      t(:'achievement.singular')
    end

  end
end
