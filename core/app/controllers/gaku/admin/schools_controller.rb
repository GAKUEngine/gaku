module Gaku
  class Admin::SchoolsController < Admin::BaseController

    respond_to :js,   only: %i( new create destroy )
    respond_to :html, only: %i( index edit edit_master update update_master show show_master )

    before_action :set_school,  only: %i( edit show update destroy )
    before_action :set_master_school, only: %i( show_master edit_master update_master )

    def show_master
      respond_with @school
    end

    def edit_master
      respond_with @school
    end

    def destroy
      @school.destroy
      set_count
      respond_with @school
    end

    def new
      @school = School.new
      respond_with @school
    end

    def create
      @school = School.new(school_params)
      @school.save
      set_count
      respond_with @school
    end

    def edit
      respond_with @school
    end

    def show
      respond_with @school
    end

    def update
      @school.update(school_params)
      respond_with @school, location: [:edit, :admin, @school]
    end

    def update_master
      @school.update(school_params)
      respond_with @school, location: admin_school_details_edit_path
    end

    def index
      @schools = School.all
      set_count
      respond_with @schools
    end

    private

    def school_params
      params.require(:school).permit(attributes)
    end

    def attributes
      [:name, :primary, :slogan, :description, :founded, :principal, :vice_principal, :grades, :code, { levels_attributes: [ :name, :'_destroy', :id ] }, :picture ]
    end

    def set_school
      @school = School.find(params[:id])
    end

    def set_count
      @count = School.count
    end

    def set_master_school
      @school = School.primary
    end

  end

end
