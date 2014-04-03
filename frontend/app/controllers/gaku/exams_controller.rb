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
        format.json { render json: @exams.as_json(include: {exam_portions: {include: :exam_portion_scores}})}
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
      if @exam.save
        @exam.use_primary_grading_method_set
      end
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


    def grading
      @course = Course.find(params[:course_id])
      @students = @course.students #.select("id, surname, name")
      find_exams

      calculate_totals
      calculate_exam_averages
      calculate_deviation
      calculate_rank_and_grade

      @path_to_exam = course_path(id: params[:course_id])

      #exam_portions need reload to properly include exam_portion_score in as_json
      @exams.each { |exam| exam.exam_portions.reload }

      respond_to do |format|
        format.json do render json: {
          student_total_scores: @student_total_scores.as_json,
          exams: @exams.as_json(include: {exam_portions: {include: :exam_portion_scores }},root: false),
          course: @course.as_json(root: false),
          exam_averages: @exam_averages.as_json(root: false),
          deviation: @deviation.as_json(root: false),
          students: @students.to_json(root: false),
          grades: @grades.as_json(root: false),
          ranks: @ranks.as_json(root: false),
          attendances: @student_portion_attendance.as_json(root: true, include: :attendance_type),
          path_to_exam: @path_to_exam.to_json,
          completion: @completion
        }end
        format.html { render 'gaku/exams/grading' }
      end
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
      if params[:id] != nil
        @exams = Exam.where(id: params[:id])
      else
        @exams = @course.syllabus.exams
      end
    end
  end
end
