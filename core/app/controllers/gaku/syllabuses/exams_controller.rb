module Gaku
  class Syllabuses::ExamsController < GakuController

    inherit_resources
    actions :index, :show, :new, :update, :edit, :destroy

    before_filter :load_syllabus, :only => [:create, :edit]
    before_filter :grading_methods, :only => [:edit]
    before_filter :load_exam_syllabus, :only => [:update]


    respond_to :js, :html

    def create
   	  exam = Exam.create(params[:exam])
   	  flash.now[:notice] = t('exams.exam_created')
  	  respond_to do |format|
        if @syllabus.exams << exam
          format.js { render 'create' }  
        end
      end  
    end

    private

    def load_syllabus
      @syllabus = Syllabus.find(params[:syllabus_id])
    end

    def grading_methods
        @grading_methods = GradingMethod.all
    end

    def load_exam_syllabus
      @exam_syllabus = ExamSyllabus.where(:exam_id => params[:id], :syllabus_id => params[:syllabus_id]).first
    end

  end
end