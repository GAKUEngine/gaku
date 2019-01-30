module Gaku
  class Courses::Exams::ExamPortionScoresController < GakuController
    respond_to :js

    def update
      @exam_portion_score = ExamPortionScore.find(params[:id])
      @exam_portion_score.update_attributes(exam_portion_score_params)

      respond_with @exam_portion_score
    end

    private

    def exam_portion_score_params
      params.require(:exam_portion_score).permit(attributes)
    end

    def attributes
      %i[score]
    end
  end
end
