class Syllabuses::ExamsController < ApplicationController

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def create
 	  @syllabus = Syllabus.find(params[:syllabus_id])
 	  exam = Exam.create(params[:exam])
 	  flash.now[:notice] = t('exams.exam_created')
	  respond_to do |format|
      if @syllabus.exams << exam
        format.js { render 'create' }  
      end
    end  
  end

  def destroy
    super do |format|
      format.js { render 'destroy' }
    end
  end
=begin
  def create
    exam = Exam.create(params[:syllabus][:exam])
    if  @syllabus.exams << exam
      flash.now[:notice] = t('exams.exam_created')
      respond_to do |format|
       format.js { render 'create' }  
      end
    end  
  end
=end
end