class ExamsController < ApplicationController

  #before_filter :authenticate_user!
  before_filter :load_exam, :only => [:show, :destroy, :create_exam_portion]
  before_filter :load_before_show, :only => :show

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy
  
  def index
    if params[:course_id]
      @exams = Course.find(params[:course_id]).syllabus.exams
    else
      @exams = Exam.all()
    end

    respond_to do |format|
      format.html
      format.json { render :json => @exams}
    end
  end

  def create_exam_portion
    if @exam.update_attributes(params[:exam])
      respond_to do |format|
        format.js {render 'create_exam_portion'}
      end
    end    
  end

  def new
    @exam = Exam.new
    @master_portion = @exam.exam_portions.new  
  end
  
  def destroy
    #destroy! :flash => !request.xhr?
    @exam.destroy
    respond_to do |format|
        format.js { render :nothing => true }
    end
  end

  def grading
    @course = Course.find(params[:course_id])
    @exam = Exam.find(params[:id])
    render "exams/grading"
  end

  private
    def load_exam 
    	@exam = Exam.find(params[:id])
    end

    def load_before_show
      @exam.exam_portions.build
    end
end
