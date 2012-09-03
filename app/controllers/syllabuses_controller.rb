class SyllabusesController < ApplicationController

  #before_filter :authenticate_user!

  before_filter :load_syllabus,    :only  => [:create_exam, :create_assignment, :show]
  before_filter :load_before_show, :only => :show

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def destroy
    destroy! :flash => !request.xhr?
  end

  def update
    super do |format|
      format.js
    end  
  end

  def create_exam
    exam = Exam.create(params[:syllabus][:exam])
    if  @syllabus.exams << exam
      flash.now[:notice] = t('exams.exam_created')
      respond_to do |format|
       format.js {render 'create_exam'}  
      end
    end  
  end

  def create_assignment
    if @syllabus.update_attributes(params[:syllabus])
      respond_to do |format|
        format.js {render 'create_assignment'}  
      end
    end  
  end

  private
    def load_syllabus 
    	@syllabus = Syllabus.find(params[:id])
    end

    def load_before_show
      @exam = Exam.new
      @exam.exam_portions.build
      @syllabus.assignments.build
    end

end
