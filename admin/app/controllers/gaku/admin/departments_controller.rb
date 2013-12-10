module Gaku
  class Admin::DepartmentsController < Admin::BaseController

    #load_and_authorize_resource class: Department

    respond_to :js,   only: %i( new create edit update destroy )
    respond_to :html, only: :index

    before_action :set_department, only: %i( edit update destroy )

    def index
      @departments = Department.all
      @count = Department.count
      respond_with @departments
    end

    def new
      @department = Department.new
      respond_with @department
    end

    def create
      @department = Department.new(department_params)
      @department.save
      @count = Department.count
      respond_with @department
    end

    def edit
    end

    def update
      @department.update(department_params)
      respond_with @department
    end

    def destroy
      @department.destroy
      @count = Department.count
      respond_with @department
    end

    private

    def set_department
      @department = Department.find(params[:id])
    end

    def department_params
      params.require(:department).permit(:name)
    end


  end
end
