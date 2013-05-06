module Gaku
  class ExamPortionScoresController < GakuController
    inherit_resources

    respond_to :js, :json, :html

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
