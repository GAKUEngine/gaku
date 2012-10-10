class ExamPortionsController < ApplicationController
	
  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy
  before_filter :load_exam, :only => [:show, :edit, :update, :destroy ]

  def show
    @attachment = Attachment.new
    super do |format|
      format.html {render 'exams/exam_portions/show'}
    end
  end

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
    @portion_id = @exam_portion.id
    @exam_portion.destroy
    @total_weight=get_total_weight(@exam.exam_portions)
    super do |format|
      format.js { render 'exams/exam_portions/destroy' }
    end
  end

  private 
    def load_exam
      @exam = Exam.find(params[:exam_id])
    end

    def get_total_weight(portions)
      total=0
      portions.each do |portion|
        total+=portion.weight
      end
      total
    end
end
