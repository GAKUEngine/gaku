module Gaku
  module Api
    module V1
      class EnrollmentStatusesController < BaseController
        skip_before_action :authenticate_request

        def index
          @enrollment_statuses = EnrollmentStatus.all
          collection_respond_to @enrollment_statuses, root: :enrollment_statuss
        end

        def create
          @enrollment_statuses = EnrollmentStatus.create!(enrollment_status_params)
          member_respond_to @enrollment_statuses
        end

        private

        def enrollment_status_params
          params.require(:name)
          params.permit(:name)
        end

      end
    end
  end
end
