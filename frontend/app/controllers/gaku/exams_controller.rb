module Gaku
  class ExamsController < GakuController

    include Gaku::Grading::Calculations

    respond_to :html, :js, :json
    respond_to :xls, only: :export

    before_action :set_exam,    only: %i( show edit update destroy )
    before_action :load_data, only: %i( new edit )

    def index
      if params[:course_id]
        @exams = Course.find(params[:course_id]).syllabus.exams
      else
        @search = Exam.includes(:department).search(params[:q])
        results = @search.result(distinct: true)
        @exams = results.page(params[:page])
        @exam = Exam.new
        @exam_sessions = ExamSession.all
      end

      @exam.exam_portions.build
      set_count
      respond_to do |format|
        format.html
        format.json { render json: @exams.as_json(include: { exam_portions: { include: :exam_portion_scores } }) }
      end
    end

    def show
      respond_with @exam
    end

    def new
      @exam = Exam.new
      @master_portion = @exam.exam_portions.new
      respond_with @exam
    end

    def create
      @exam = Exam.new(exam_params)
      @exam.use_primary_grading_method_set if @exam.save
      set_count
      respond_with @exam
    end

    def edit
      respond_with @exam
    end

    def update
      @exam.update(exam_params)
      respond_with @exam, location: [:edit, @exam]
    end

    def destroy
      @exam.destroy
      set_count
      respond_with @exam
    end

    def export
      @course = Course.find(params[:course_id])
    end

    def completed
      @exam = Exam.find(params[:id])
      @course = Course.find(params[:course_id])
      @students = @course.students

      respond_with @exam.completed_by_students(@students)
    end

    protected

    def exam_params
      params.require(:exam).permit(attributes)
    end

    private

    def load_data
      @departments = Department.all
    end

    def t_resource
      t(:'exam.singular')
    end

    def attributes
      [:name, :department_id, :weight, :description, :adjustments, :use_weighting,
       exam_portions_attributes: [:id, :name, :weight, :problem_count, :max_score, :description, :adjustments]
      ]
    end

    def includes
      { grading_method_connectors: :grading_method }
    end

    def set_exam
      @exam = Exam.includes(includes).find(params[:id])
      set_notable
      set_gradable
    end

    def set_notable
      @notable = @exam
      @notable_resource = @notable.class.to_s.demodulize.underscore.dasherize
    end

    def set_gradable
      @gradable = @exam
      @gradable_resource = @gradable.class.to_s.demodulize.underscore.dasherize
    end

    def set_count
      @count = Exam.count
    end

    def find_exams
      if params[:id]
        @exams = Exam.where(id: params[:id])
      else
        @exams = @course.syllabus.exams
      end
    end
  end
end
