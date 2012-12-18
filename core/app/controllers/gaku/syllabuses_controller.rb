module Gaku
  class SyllabusesController < GakuController

    #before_filter :load_before_index, :only => :index
    #before_filter :load_before_show,  :only => [:show, :destroy]
    before_filter :load_before_show,  :only => :show
    before_filter :count, :only => [:create, :destroy, :index]

    inherit_resources
    actions :index, :show, :new, :create, :update, :edit, :destroy

    respond_to :js, :html

    #def destroy
    #  super do |format|
    #    format.js { render }
    #  end
    #end

    private

      #def load_before_index
      #  @syllabus = Syllabus.new
      #end

      def syllabus
      	@syllabus = Syllabus.find(params[:id])
      end

      def grading_methods
        @grading_methods = GradingMethod.all
      end

      def load_before_show
        syllabus

        #@exam = Exam.new
        #@exam_syllabus = ExamSyllabus.new
        #@exam.exam_portions.build
        #@syllabus.assignments.build
        @notable = @syllabus
        @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
        grading_methods
      end

      def count
        @count = Syllabus.count
      end

  end
end
