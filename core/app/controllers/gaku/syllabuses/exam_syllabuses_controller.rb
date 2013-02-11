module Gaku
	class Syllabuses::ExamSyllabusesController < GakuController

    #authorize_resource :class => false
    load_and_authorize_resource :syllabus, :class => Gaku::Syllabus
    load_and_authorize_resource :exam_syllabus, :through => :syllabus, :class => Gaku::ExamSyllabus

		inherit_resources
    actions :create, :destroy
    belongs_to :syllabus, :parent_class => Gaku::Syllabus
    respond_to :js, :html

    before_filter :count, :only => [:create,:destroy]

    def create
    	create!(:notice => t('notice.added', :resource => t('exam.singular')))
    end

		private

		def count
		  @syllabus = Syllabus.find(params[:syllabus_id])
			@count = @syllabus.exams.count
		end

	end
end
