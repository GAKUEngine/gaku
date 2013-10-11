module Gaku
  class Syllabuses::ExamsController < GakuController

    load_and_authorize_resource :syllabus, class: Gaku::Syllabus
    load_and_authorize_resource :exam, through: :syllabus, class: Gaku::Exam

    inherit_resources
    belongs_to :syllabus, parent_class: Gaku::Syllabus
    respond_to :js, :html

    before_filter :syllabus
    before_filter :exam_syllabus, only: :update
    before_filter :load_data

    def create
      @exam = @syllabus.exams.create(params[:exam])
      create!
    end

    def new
      @exam = @syllabus.exams.new
      @exam.exam_portions.build
      new!
    end

    protected

    def resource_params
      return [] if request.get?
      [params.require(:exam).permit!]
    end

    private

    def exam_attr
      [:name, :description, :adjustments, { exam_portions_attributes: [] }]
    end

    def load_data
      @grading_methods = GradingMethod.pluck(:name, :id)
    end

    def syllabus
      @syllabus = Syllabus.find(params[:syllabus_id])
    end

    def exam_syllabus
      @exam_syllabus = ExamSyllabus.find_by(exam_id: params[:id], syllabus_id: params[:syllabus_id])
    end


  end
end
