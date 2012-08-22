class ExamsController < ApplicationController

  #before_filter :authenticate_user!
  before_filter :load_exam, :only => [:show, :destroy, :create_exam_portion]
  before_filter :load_before_show, :only => :show

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy
  
  def index
    if params[:course_id]
      @exams = Course.find(params[:course_id]).syllabus.exams
    else
      @exams = Exam.all()
    end

    respond_to do |format|
      format.html
      format.json { render :json => @exams}
    end
  end

  def create_exam_portion
    if @exam.update_attributes(params[:exam])
      respond_to do |format|
        format.js {render 'exams/exam_portions/create_exam_portion'}
      end
    end    
  end

  def new
    @exam = Exam.new
    @master_portion = @exam.exam_portions.new  
  end
  
  def destroy
    #destroy! :flash => !request.xhr?
    @exam.destroy
    respond_to do |format|
        format.js { render :nothing => true }
    end
  end

  def grading
    @course = Course.find(params[:course_id])
    @students = @course.students #.select("id, surname, name")
    if params[:id] != nil
      @exams = Exam.find_all_by_id(params[:id])
    else
      @exams = @course.syllabus.exams.all
      #TODO calculate all grades and put them in here
      @grades = 1
    end

    @student_total_scores = {}
    @student_total_scores.default = 0
    @student_total_weights = {}
    @student_total_weights.default = 0
    @weighting_score = true


    @students.each do |student|
      @exams.each do |exam|
        exam.exam_portions.each do |portion|
          if student.exam_portion_scores.where(:exam_portion_id => portion.id).first.nil?
            score = ExamPortionScore.new
            score.student_id = student.id
            score.exam_portion_id = portion.id
            score.save
          else
            @student_total_scores[student.id] += student.exam_portion_scores.where(:exam_portion_id => portion.id).first.score.to_f
            if exam.use_weighting
              @student_total_weights[student.id] +=  (portion.weight.to_f / 100) * student.exam_portion_scores.where(:exam_portion_id => portion.id).first.score.to_f
            end
          end
        end
      end
    end
    render "exams/grading"
  end

  def update_score
    @exam_portion_score = ExamPortionScore.find_or_create_by_student_id_and_exam_portion_id(params[:exam_portion_score][:student_id], params[:exam_portion_score][:exam_portion_id])
    @exam_portion_score.score = params[:exam_portion_score][:score]
    if @exam_portion_score.save
      @student_id = Student.find(params[:exam_portion_score][:student_id]).id
      exam = Exam.find(params[:id])
      exam_portions = exam.exam_portions
      exam_portions_ids = exam_portions.pluck(:id)
      student_exam_portion_scores = ExamPortionScore.where("student_id =#{params[:exam_portion_score][:student_id]}", "exam_portion_id in #{exam_portions_ids}")
      student_scores = student_exam_portion_scores.pluck(:score)
      @student_total_score = student_scores.inject{|sum,x| sum + x.to_f }
      
      @student_weights_total = 0.0
      if exam.use_weighting  
        student_exam_portion_scores.each do |eps|
          @student_weights_total += eps.score.to_f * (eps.exam_portion.weight.to_f / 100)
        end
      end
        
      respond_to do |format|
        
          format.js { render 'update_score' }
        end
      end
  end

  private
    def load_exam 
    	@exam = Exam.find(params[:id])
    end

    def load_before_show
      @exam.exam_portions.build
    end
end
