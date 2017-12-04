module Gaku
  module Api
    module V1
      module Students
        class CoursesController < BaseController

          before_action :set_student
          skip_before_action :authenticate_request


          def index
            @courses = @student.courses
            respond_to do |format|
              format.json { render json: @courses, root: :courses, adapter: :json }
              format.msgpack { render msgpack: @courses, root: :courses, adapter: :json }
            end
          end

          private

          def set_student
            @student = Gaku::Student.find(params[:student_id])
          end

        end
      end
    end
  end
end
