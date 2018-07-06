module Gaku
  module Api
    module V1
      class ExamPortionScoresController < BaseController
        skip_before_action :authenticate_request

        before_action :set_exam_portion_score

        def update
          @exam_portion_score.update(exam_portion_score_params)

          exam = @exam_portion_score.exam_portion.exam
          serialized_exam_portion_score = Gaku::ExamPortionScoreSerializer.new(@exam_portion_score)

          broadcast_scoring(exam, serialized_exam_portion_score)
          broadcast_grading(exam, 'TEST')

          member_respond_to @exam_portion_score
        end

        private

        def broadcast_scoring(exam, data)
          ActionCable.server.broadcast("exam_#{exam.id}", data)
        end

        def broadcast_grading(exam, data)
          ActionCable.server.broadcast("grading_exam_#{exam.id}", data)
        end

        def exam_portion_score_params
          params.require(:score)
          params.permit(:score)
        end

        def set_exam_portion_score
          @exam_portion_score = Gaku::ExamPortionScore.find(params[:id])
        end

      end
    end
  end
end
