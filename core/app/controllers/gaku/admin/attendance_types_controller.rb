module Gaku
  class Admin::AttendanceTypesController < Admin::BaseController

    load_and_authorize_resource class: AttendanceType

    respond_to :js, :html, :json

    inherit_resources

    before_filter :count, only: %i(create destroy index)

    def index
      super do |format|
        format.json { render json: @attendance_types.to_json(root: false) }
      end
    end

    protected

    def resource_params
      return [] if request.get?
      [params.require(:attendance_type).permit(attributes)]
    end

    private

    def count
      @count = AttendanceType.count
    end

    def attributes
      %i(name color_code counted_absent disable_credit credit_rate auto_credit)
    end

  end
end

