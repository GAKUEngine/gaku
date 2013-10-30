module Gaku
  class Admin::SpecialtiesController < Admin::BaseController

    #load_and_authorize_resource class: Specialty

    respond_to :js,   only: %i( new create edit update destroy )
    respond_to :html, only: :index

    before_action :set_specialty, only: %i( edit update destroy )
    before_action :load_data, only: %i( new edit )

    def index
      @specialties = Specialty.all
      @count = Specialty.count
      respond_with @specialtys
    end

    def new
      @specialty = Specialty.new
      respond_with @specialty
    end

    def create
      @specialty = Specialty.new(specialty_params)
      @specialty.save
      @count = Specialty.count
      respond_with @specialty
    end

    def edit
    end

    def update
      @specialty.update(specialty_params)
      respond_with @specialty
    end

    def destroy
      @specialty.destroy
      @count = Specialty.count
      respond_with @specialty
    end

    private

    def set_specialty
      @specialty = Specialty.find(params[:id])
    end

    def load_data
      @departments = Department.all
    end

    def specialty_params
      params.require(:specialty).permit(attributes)
    end

    def attributes
      %i(name description major_only department_id)
    end

  end
end
