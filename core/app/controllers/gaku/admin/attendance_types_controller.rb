module Gaku
  module Admin
    class AttendanceTypesController < Admin::BaseController

      load_and_authorize_resource class: Gaku::AttendanceType

    	inherit_resources
      respond_to :js, :html, :json
      before_filter :count, only: [:create, :destroy, :index]

      def index
        super do |format|
          format.json { render json: @attendance_types.to_json(root: false) }
        end
      end

      protected

      def resource_params
        return [] if request.get?
        [params.require(:attendance_type).permit(attendance_type_attr)]
      end

      private

      def count
        @count = AttendanceType.count
      end

      def attendance_type_attr
        %i(name color_code counted_absent disable_credit credit_rate auto_credit)
      end

    end
  end
end

