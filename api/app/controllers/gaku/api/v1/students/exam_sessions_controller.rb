module Gaku
  module Api
    module V1
      module Students
        class ExamSessionsController < BaseController

          before_action :set_student

          def index
            @exam_sessions = @student.exam_sessions
            respond_to do |format|
              format.json { render json: @exam_sessions, root: :exam_sessions, adapter: :json }
              format.msgpack { render msgpack: @exam_sessions, root: :exam_sessions, adapter: :json }
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
