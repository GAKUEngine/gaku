module Gaku
  class ExamPortionScoresController < GakuController

    respond_to :js

    def update
      @exam_portion_score = ExamPortionScore.find(params[:id])
      @exam_portion_score.update_attributes(exam_portion_score_params)

      score = GradingMethods::Score.new(@exam_portion_score.exam_portion.exam, [@exam_portion_score.student]).grade
      message = { exam_portion_score: @exam_portion_score, score: score }
      $redis.publish('grading-change', message.to_json)

      render nothing: true
    end

    private

    def exam_portion_score_params
      params.require(:exam_portion_score).permit(attributes)
    end

    def attributes
      %i( score )
    end

  end
end
