module Gaku
  class Syllabuses::ExamsController < GakuController

    respond_to :js, only: %i( new create edit update destroy )

    before_action :set_syllabus
    before_action :set_exam, only: %i( edit update destroy )
    before_action :set_grading_methods, only: %i( new edit )

    def new
      @exam = Exam.new
      @exam.exam_portions.build
      respond_with @exam
    end

    def create
      @exam = Exam.new(exam_params)
      @exam.department = @syllabus.department
      @exam.save!
      @syllabus.exams << @exam

      set_count
      respond_with @exam
    end

    def edit
    end

    def update
      @exam.update(exam_params)
      respond_with @exam
    end

    def destroy
      @exam.destroy
      set_count
      respond_with @exam
    end

    private

    def exam_params
      params.require(:exam).permit(attributes)
    end

    def attributes
      [:name, :description, :adjustments, :grading_method_id, exam_portions_attributes: [:id, :name, :weight, :problem_count, :max_score, :description, :adjustments]]
    end

    def set_exam
      @exam = Exam.find(params[:id])
    end

    def set_grading_methods
      @grading_methods = GradingMethod.pluck(:name, :id)
    end

    def set_syllabus
      @syllabus = Syllabus.find(params[:syllabus_id])
    end

    def set_count
      @exams_count = @syllabus.reload.exams_count
    end


  end
end
