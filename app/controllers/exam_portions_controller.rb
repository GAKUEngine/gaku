class ExamPortionsController < ApplicationController
	
  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy
  before_filter :load_exam, :only => [ :edit, :update ]

  def edit
    super do |format|
      format.js {render 'exams/exam_portions/edit'}  
    end  
  end

  def update
    super do |format|
      format.js { render 'exams/exam_portions/update' }  
    end  
  end


  def destroy
    #destroy! :flash => !request.xhr?
    @exam_portion = ExamPortion.find(params[:id])
    @exam_portion.destroy
    respond_to do |format|
        format.js { render :nothing => true }
    end
  end

  private 
    def load_exam
      @exam = Exam.find(params[:exam_id])
    end
end
