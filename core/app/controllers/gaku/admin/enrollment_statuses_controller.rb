module Gaku
  module Admin
    class EnrollmentStatusesController < Admin::BaseController

      load_and_authorize_resource class: Gaku::EnrollmentStatus

      inherit_resources
      respond_to :js, :html

      before_filter :count, only: [:create, :destroy, :index]

      protected

      def collection
        @enrollment_statuses = EnrollmentStatus.includes(:translations)
      end

      def resource_params
        return [] if request.get?
        [params.require(:enrollment_status).permit(enrollment_status_attr)]
      end

      private

      def count
        @count = EnrollmentStatus.count
      end

      def enrollment_status_attr
        %i(code name is_active immutable)
      end

    end
  end
end
