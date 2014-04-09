module Gaku
  class Admin::AttendanceTypesController < Admin::BaseController

    #load_and_authorize_resource class: AttendanceType

    respond_to :json, only: :index
    respond_to :js,   only: %i( new create edit update destroy index )

    before_action :set_attendance_type, only: %i( edit update destroy )

    def index
      @attendance_types = AttendanceType.all
      set_count
      respond_with @attendance_types
    end

    def new
      @attendance_type = AttendanceType.new
      respond_with @attendance_type
    end

    def create
      @attendance_type = AttendanceType.new(attendance_type_params)
      @attendance_type.save
      set_count
      respond_with @attendance_type
    end

    def edit
    end

    def update
      @attendance_type.update(attendance_type_params)
      respond_with @attendance_type
    end

    def destroy
      @attendance_type.destroy
      set_count
      respond_with @attendance_type
    end

    private

    def set_attendance_type
      @attendance_type = AttendanceType.find(params[:id])
    end

    def attendance_type_params
      params.require(:attendance_type).permit(attributes)
    end

    def attributes
      %i(name color_code counted_absent disable_credit credit_rate auto_credit)
    end

    def set_count
      @count = AttendanceType.count
    end

  end
end

