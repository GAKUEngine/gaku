module Gaku
  class Admin::SchoolYears::SemestersController < Admin::BaseController

    respond_to :js, only: %i( new create edit update destroy )

    before_action :set_school_year
    before_action :set_semester, only: %i( edit update destroy )


    def new
      @semester = Semester.new
    end

    def create
      @semester = @school_year.semesters.build(semester_params)
      @semester.save
      set_count
      respond_with @semester
    end

    def edit
    end

    def update
      @semester.update(semester_params)
      respond_with @semester
    end

    def destroy
      @semester.destroy
      set_count
      respond_with @semester
    end

    private

    def semester_params
      params.require(:semester).permit(attributes)
    end

    def set_semester
      @semester = Semester.find(params[:id])
    end

    def set_school_year
      @school_year = SchoolYear.find(params[:school_year_id])
    end

    def set_count
      @count = @school_year.semesters.count
    end

    def attributes
      %i( starting ending )
    end

  end
end
