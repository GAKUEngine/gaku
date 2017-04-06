module Gaku
  module Api
    module V1
      module Students
        class ExtracurricularActivitiesController < BaseController

          before_action :set_student

          def index
            @extracurricular_activities = @student.extracurricular_activities
            respond_to do |format|
              format.json { render json: @extracurricular_activities, root: :extracurricular_activities, adapter: :json }
              format.msgpack { render msgpack: @extracurricular_activities, root: :extracurricular_activities, adapter: :json }
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
