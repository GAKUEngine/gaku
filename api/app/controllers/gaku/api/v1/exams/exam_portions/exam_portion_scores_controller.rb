module Gaku
  module Api
    module V1
      module Exams
        module ExamPortions
          class ExamPortionScoresController < BaseController
            skip_before_action :authenticate_request

            before_action :set_exam_portion

            def index
              @exam_portion_scores = @exam_portion.exam_portion_scores
              respond_to do |format|
                format.json { render json: @exam_portion_scores, root: :exam_portion_scores, adapter: :json }
                format.msgpack { render msgpack: @exam_portion_scores, root: :exam_portion_scores, adapter: :json }
              end
            end

            private

            def set_exam_portion
              @exam_portion = Gaku::ExamPortion.find(params[:exam_portion_id])
            end

          end
        end
      end
    end
  end
end
