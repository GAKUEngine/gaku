module Gaku
  class Admin::BadgeTypesController < Admin::BaseController

    #load_and_authorize_resource class: Achievement

    respond_to :js, only: %i( new create edit update destroy index )

    before_action :set_badge_type, only: %i( edit update destroy )

    def index
      @badge_types = BadgeType.all
      set_count
      respond_with @badge_types
    end

    def new
      @badge_type = BadgeType.new
      respond_with @badge_type
    end

    def create
      @badge_type = BadgeType.new(badge_type_params)
      if @badge_type.save
        set_count
        respond_with @badge_type
      else
        render :new
      end
    end

    def edit
    end

    def update
      @badge_type.update(badge_type_params)
      respond_with @badge_type
    end

    def destroy
      @badge_type.destroy
      set_count
      respond_with @badge_type
    end

    private

    def set_badge_type
      @badge_type = BadgeType.find(params[:id])
    end

    def badge_type_params
      params.require(:badge_type).permit(attributes)
    end

    def set_count
      @count = BadgeType.count
    end

    def attributes
      %i( name description code authority url issuer badge_image )
    end

  end
end
