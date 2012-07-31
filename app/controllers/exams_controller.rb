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
        format.js {render 'create_exam_portion'}
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
    @exams = Exam.find_all_by_id(params[:id])
    @examDetails = []
    @exams.each do |exam|
      maxScore = 0.0
      portions = []
      exam.exam_portions.each do |portion|
        maxScore += portion.max_score
        portions.push({ :id => portion.id, :name => portion.name, :max_score => portion.max_score })
      end

      @examDetails.push({ :id => exam.id, :name => exam.name, :max_score => maxScore, :portions => portions })
    end


    @students.each do |student|
      @exams.each do |exam|
        exam.exam_portions.each do |portion|
          if student.exam_portion_scores.where(:exam_portion_id => portion.id).first.nil?
            score = ExamPortionScore.new
            score.student_id = student.id
            score.exam_portion_id = portion.id
            score.save
          end
        end
      end
    end

    render "exams/grading"
  end

  private
    def load_exam 
    	@exam = Exam.find(params[:id])
    end

    def load_before_show
      @exam.exam_portions.build
    end
end
