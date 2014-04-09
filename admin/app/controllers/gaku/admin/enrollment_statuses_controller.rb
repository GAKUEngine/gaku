module Gaku
  class Admin::EnrollmentStatusesController < Admin::BaseController

    #load_and_authorize_resource class: EnrollmentStatus

    respond_to :js,   only: %i( new create edit update destroy index )

    before_action :set_enrollment_status, only: %i( edit update destroy )

    def index
      @enrollment_statuses = EnrollmentStatus.includes(:translations)
      set_count
      respond_with @enrollment_statuss
    end

    def new
      @enrollment_status = EnrollmentStatus.new
      respond_with @enrollment_status
    end

    def create
      @enrollment_status = EnrollmentStatus.new(enrollment_status_params)
      @enrollment_status.save
      set_count
      respond_with @enrollment_status
    end

    def edit
    end

    def update
      @enrollment_status.update(enrollment_status_params)
      respond_with @enrollment_status
    end

    def destroy
      @enrollment_status.destroy
      set_count
      respond_with @enrollment_status
    end

    private

    def set_enrollment_status
      @enrollment_status = EnrollmentStatus.find(params[:id])
    end

    def enrollment_status_params
      params.require(:enrollment_status).permit(attributes)
    end

    def attributes
      %i( code name active immutable )
    end

    def set_count
      @count = EnrollmentStatus.count
    end

  end
end
