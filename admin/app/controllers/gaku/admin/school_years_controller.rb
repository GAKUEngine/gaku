module Gaku
  class Admin::SchoolYearsController < Admin::BaseController

    respond_to :html, only: %i( edit )
    respond_to :js,   only: %i( index new create destroy edit update )

    before_action :set_school_year, only: %i( edit update destroy )

    def index
      @school_years = SchoolYear.all
      set_count
      respond_with @school_years
    end

    def new
      @school_year = SchoolYear.new
    end

    def create
      @school_year = SchoolYear.new(school_year_params)
      @school_year.save
      set_count
      respond_with @school_year
    end

    def edit
    end

    def update
      @school_year.update(school_year_params)
      respond_with @school_year
    end

    def destroy
      @school_year.destroy
      set_count
      respond_with @school_year
    end

    private

    def school_year_params
      params.require(:school_year).permit(attributes)
    end

    def set_school_year
      @school_year = SchoolYear.find(params[:id])
    end

    def set_count
      @count = SchoolYear.count
    end

    def attributes
      %i( starting ending )
    end

  end
end
