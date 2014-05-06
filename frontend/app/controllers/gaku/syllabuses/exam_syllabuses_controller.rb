module Gaku
  class Syllabuses::ExamSyllabusesController < GakuController

    respond_to :js, only: %i( new create destroy )

    before_action :set_syllabus

    def new
      @exam_syllabus = ExamSyllabus.new
      respond_with @exam_syllabus
    end

    def create
      @exam_syllabus = ExamSyllabus.new(exam_syllabus_params)
      @exam_syllabus.save
      set_count
      #flash[:notice] = t(:'notice.added', resource: t(:'exam.singular'))
      respond_with @exam_syllabus
    end

    def destroy
      @exam_syllabus = ExamSyllabus.find(params[:id])
      @exam_syllabus.destroy
      set_count
      respond_with @exam_syllabus
    end

    private

    def exam_syllabus_params
      params.require(:exam_syllabus).permit([:exam_id, :syllabus_id])
    end

    def set_syllabus
      @syllabus = Syllabus.find(params[:syllabus_id])
    end

    def set_count
      @exams_count = @syllabus.reload.exams_count
    end

  end
end
