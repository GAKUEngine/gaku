class Syllabuses::ExamsController < ApplicationController

  inherit_resources
  actions :index, :show, :new, :update, :edit, :destroy

  respond_to :js, :html

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

end