module Gaku
  class Admin::CampusesController < Admin::BaseController
    include AdminPictureController

    respond_to :js,   only: %i( new create destroy edit update index )
    respond_to :html, only: %i( edit update show )

    before_action :set_campus,  only: %i( edit show update destroy )
    before_action :set_school, except: %i( set_picture remove_picture )


    def destroy
      @campus.destroy
      set_count
      respond_with @campus
    end

    def new
      @campus = Campus.new
      respond_with @campus
    end

    def create
      @campus = Campus.new(campus_params)
      @campus.save
      @school.campuses << @campus
      set_count
      respond_with @campus
    end

    def edit
      respond_with @campus
    end

    def show
      respond_with @campus
    end

    def update
      @campus.update(campus_params)
      respond_with @campus
    end

    def index
      @campuses = Campus.all
      set_count
      respond_with @campus
    end

    private

    def campus_params
      params.require(:campus).permit(attributes)
    end

    def attributes
      %i( name school_id master picture )
    end

    def set_school
      @school = School.find(params[:school_id])
    end

    def set_campus
      @campus = Campus.find(params[:id])
    end

    def set_count
      @count = @school.campuses.count
    end

  end
end
