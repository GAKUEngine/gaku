module Gaku
  class Syllabuses::ExamSyllabusesController < GakuController

    #authorize_resource class: false
    #load_and_authorize_resource :syllabus, class: Gaku::Syllabus
    #load_and_authorize_resource :exam_syllabus, through: :syllabus, class: Gaku::ExamSyllabus

    inherit_resources

    defaults resource_class: ExamSyllabus,
             instance_name: 'exam_syllabus'

    actions :new, :create, :destroy
    belongs_to :syllabus, parent_class: Gaku::Syllabus
    respond_to :js, :html

    before_filter :syllabus

    def create
      #@exam_syllabus = @syllabus.exams.create(params[:exam_syllabus])
      set_count
      create!(notice: t(:'notice.added', resource: t(:'exam.singular')))
    end

    def destroy
      set_count
      destroy
    end

    protected

    def resource_params
      return [] if request.get?
      [params.require(:exam_syllabus).permit([:exam_id, :syllabus_id])]
    end

    private

    def syllabus
      @syllabus = Syllabus.find(params[:syllabus_id])
    end

    def set_count
      @exams_count = @syllabus.reload.exams_count
    end

  end
end
