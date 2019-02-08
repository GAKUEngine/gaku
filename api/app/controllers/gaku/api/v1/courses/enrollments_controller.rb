module Gaku
  module Api
    module V1
      module Courses
        class EnrollmentsController < BaseController
          before_action :set_course

          def index
            @enrollments = @course.enrollments.page(params[:page])
            collection_respond_to @enrollments, root: :enrollments
          end

          def create
            @enrollment = @course.enrollments.create!(create_enrollment_params)
            member_respond_to @enrollment
          end

          def update
            @enrollment = Enrollment.find(params[:id])
            @enrollment.update!(update_enrollment_params)
            member_respond_to @enrollment
          end

          private

          def create_enrollment_params
            params.require(:enrollment).permit(:student_id, :seat_number)
          end

          def update_enrollment_params
            params.require(:enrollment).permit(:seat_number)
          end

          def set_course
            @course = Course.find(params[:course_id])
          end
        end
      end
    end
  end
end
