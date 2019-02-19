module Gaku
  module Api
    module V1
      module Exams
        class ExamPortionsController < BaseController
          skip_before_action :authenticate_request

          before_action :set_exam

          def index
            @exam_portions = @exam.exam_portions
            respond_to do |format|
              format.json { render json: @exam_portions, root: :exam_portions, adapter: :json }
              format.msgpack { render msgpack: @exam_portions, root: :exam_portions, adapter: :json }
            end
          end

          private

          def set_exam
            @exam = Gaku::Exam.find(params[:exam_id])
          end

        end
      end
    end
  end
end
