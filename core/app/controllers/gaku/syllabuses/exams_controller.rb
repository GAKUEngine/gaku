module Gaku
  class Syllabuses::ExamsController < GakuController

    inherit_resources
    belongs_to :syllabus, :parent_class => Gaku::Syllabus
    respond_to :js, :html

    before_filter :grading_methods, :only => [:edit]
    before_filter :exam_syllabus, :only => [:update]
    before_filter :count, :only => [:create, :destroy]

    private

    def syllabus
      @syllabus = Syllabus.find(params[:syllabus_id])
    end

    def grading_methods
      @grading_methods = GradingMethod.all
    end

    def exam_syllabus
      @exam_syllabus = ExamSyllabus.where(:exam_id => params[:id], :syllabus_id => params[:syllabus_id]).first
    end

    def count
      @syllabus = Syllabus.find(params[:syllabus_id])
      @count = @syllabus.exams.count
    end

  end
end
