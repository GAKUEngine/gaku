module Gaku
  class ExamsController < GakuController
    inherit_resources
    actions :index, :show, :new, :create, :update, :edit, :destroy
    respond_to :html, :js
    respond_to :xls, :only => :export

    include Gaku::Core::Grading::Calculations

    before_filter :before_show, :only => :show
    before_filter :before_new, :only => :new
    before_filter :count, :only => [:create, :destroy, :index]


    def export
      @course = Course.find(params[:course_id])
    end

    def index
      if params[:course_id]
        @exams = Course.find(params[:course_id]).syllabus.exams
      else
        @exams = Exam.all
        @exam = Exam.new
      end

      @exam.exam_portions.build

      respond_to do |format|
        format.html
        format.json { render :json => @exams.as_json(:include => {:exam_portions => {:include => :exam_portion_scores}})}
      end
    end

    def grading
      @course = Course.find(params[:course_id])
      @students = @course.students #.select("id, surname, name")
      find_exams

      calculate_totals
      calculate_exam_averages
      calculate_deviation
      calculate_rank_and_grade

      @path_to_exam = course_path(:id => params[:course_id])

      respond_to do |format|
        format.json { render :json => {
          :student_total_scores => @student_total_scores.as_json(),
          :exams => @exams.as_json(:include => {:exam_portions => {:include => :exam_portion_scores }},:root => false),
          :course => @course.as_json(:root => false),
          :exam_averages => @exam_averages.as_json(:root => false),
          :deviation => @deviation.as_json(:root => false),
          :students => @students.to_json(:root => false),
          :grades => @grades.as_json(:root => false),
          :ranks => @ranks.as_json(:root => false),
          :attendances => @student_portion_attendance.as_json(:root => true),
          :path_to_exam => @path_to_exam.to_json
        }}
        format.html { render "gaku/exams/grading" }
      end
    end

    def calculations
      respond_to do |format|
        format.json {render :json => {:hello => :world}}
      end
    end

    private

    def before_new
      @exam = Exam.new
      @master_portion = @exam.exam_portions.new
    end

    def exam
      @exam = Exam.find(params[:id])
    end

    def before_show
      exam
      @notable = @exam
      @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
    end

    def count
      @count = Exam.count
    end

    def find_exams
      if params[:id] != nil
        @exams = Exam.find_all_by_id(params[:id])
      else
        @exams = @course.syllabus.exams.all
      end
    end
  end
end
