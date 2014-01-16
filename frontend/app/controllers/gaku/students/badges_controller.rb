[module Gaku
  class Students::BadgesController < GakuController

    respond_to :js, only: %i( new create edit update destroy index )

    before_action :set_student
    before_action :set_badge, only: %i( edit update destroy )
    before_action :set_badge_types,        only: %i( new edit )

    def new
      @badge = Badge.new
      respond_with @badge
    end

    def create
      @badge = @student.badges.create!(badge_params)
      set_count
      respond_with @badge
    end

    def edit
    end

    def update
      @badge.update(badge_params)
      respond_with @badge
    end

    def destroy
      @badge.destroy
      set_count
      respond_with @badge
    end

    def index
      @badges = @student.badges
      set_count
      respond_with @badges
    end

    private

    def badge_params
      params.require(:badge).permit(:badge_type_id)
    end

    def set_badge_types
      @badge_types = BadgeType.all
    end

    def set_student
      @student = Student.find(params[:student_id]).decorate
    end

    def set_badge
      @badge = Badge.find(params[:id])
    end

    def set_count
      @count = @student.badges.count
    end

  end
end
]
