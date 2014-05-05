module Gaku
  class ExamPortionScoresController < GakuController

    respond_to :js

    def update
      @exam_portion_score = ExamPortionScore.find(params[:id])
      @exam_portion_score.update_attributes(exam_portion_score_params)
      esp_json = @exam_portion_score.to_json
      ActiveRecord::Base.connection.execute "NOTIFY update_exam_portion_score, '#{esp_json}'"

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
