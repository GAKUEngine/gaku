module Gaku
  class NotesController < GakuController

  	before_filter :notable
    inherit_resources
    respond_to :js, :html

    def new
      @note = @notable.notes.new
      new!
    end

    def create
    	@note = @notable.notes.new(params[:note])
      create!
    end

    protected

    def collection
      @notes = @notable.notes
    end

    private

  	def notable
      unnamespaced_klass = ''
      klass = [Gaku::Student, Gaku::LessonPlan, Gaku::Syllabus, Gaku::ClassGroup, Gaku::Course, Gaku::Exam].detect do |c|
        unnamespaced_klass = c.to_s.split("::")
        params["#{unnamespaced_klass[1].underscore}_id"]
      end

      @notable = klass.find(params["#{unnamespaced_klass[1].underscore}_id"])
      @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
    end

  end
end
