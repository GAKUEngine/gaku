module Gaku
  class SyllabusesController < GakuController

    load_and_authorize_resource :class =>  Gaku::Syllabus

    before_filter :before_show,  :only => :show
    before_filter :count, :only => [:create, :destroy, :index]

    inherit_resources
    respond_to :js, :html

    private

    def syllabus
    	@syllabus = Syllabus.includes(includes).find(params[:id])
    end

    def includes
      [{:exam_syllabuses => [:exam, :syllabus]}]
    end

    def grading_methods
      @grading_methods = GradingMethod.all
    end

    def before_show
      syllabus
      @notable = @syllabus
      @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
      grading_methods
    end

    def count
      @count = Syllabus.count
    end

  end
end
