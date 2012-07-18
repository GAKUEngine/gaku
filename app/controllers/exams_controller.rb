class ExamsController < ApplicationController

  #before_filter :authenticate_user!
  before_filter :load_exam, :only => :show
  before_filter :load_before_show, :only => :show

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def create_exam_portion
    @exam = Exam.find(params[:id])
    if  @exam.update_attributes(params[:exam])
      respond_to do |format|
        format.js {render 'create_exam_portion'}
      end
    end    
  end


  def destroy
    #destroy! :flash => !request.xhr?
    @exam = Exam.find(params[:id])
    @exam.destroy
    respond_to do |format|
        format.js { render :nothing => true }
    end
  end

  private
    def load_exam 
    	@exam = Exam.find(params[:id])
    end

    def load_before_show
      @exam.exam_portions.build
    end

end
