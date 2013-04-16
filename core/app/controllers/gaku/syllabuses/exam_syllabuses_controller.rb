module Gaku
  class Syllabuses::ExamSyllabusesController < GakuController

    #authorize_resource :class => false
    load_and_authorize_resource :syllabus, :class => Gaku::Syllabus
    load_and_authorize_resource :exam_syllabus, :through => :syllabus, :class => Gaku::ExamSyllabus

    inherit_resources
    actions :create, :destroy
    belongs_to :syllabus, :parent_class => Gaku::Syllabus
    respond_to :js, :html

    def create
      create!(:notice => t(:'notice.added', :resource => t(:'exam.singular')))
    end

  end
end
