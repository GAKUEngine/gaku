module Gaku
  class ExamPortionScoresController < GakuController

    respond_to :js, only: :update

    def update
      @exam_portion_score = ExamPortionScore.find(params[:id])
      if @exam_portion_score.update_attributes(params[:exam_portion_score])
        respond_to do |format|
          format.js { render nothing: true }
        end
      else
        #render :edit
      end
    end
  end
end
