class ExamPortionsController < ApplicationController
	
  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def destroy
    #destroy! :flash => !request.xhr?
    @exam_portion = ExamPortion.find(params[:id])
    @exam_portion.destroy
    respond_to do |format|
        format.js { render :nothing => true }
    end
  end
  
end
