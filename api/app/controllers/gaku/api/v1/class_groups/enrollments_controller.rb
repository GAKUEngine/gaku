module Gaku
  module Api
    module V1
      module ClassGroups
        class EnrollmentsController < BaseController
          before_action :set_class_group

          def index
            @enrollments = @class_group.enrollments.page(params[:page ])
            collection_respond_to @enrollments, root: :enrollments

          end

          def create
            @enrollment = @class_group.enrollments.create(create_enrollment_params)
            member_respond_to @enrollment
          end

          def update
            @enrollment = Enrollment.find(params[:id])
            @enrollment.update!(update_enrollment_params)
            member_respond_to @enrollment
          end

          private

          def create_enrollment_params
            params.require(:student_id)
            params.permit(:student_id, :seat_number)
          end

          def update_enrollment_params
            params.permit(:seat_number)
          end

          def set_class_group
            @class_group = ClassGroup.find(params[:class_group_id])
          end

        end
      end
    end
  end
end
