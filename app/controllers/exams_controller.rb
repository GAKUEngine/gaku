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
      format.json { render :json => @exams.as_json(:include => {:exam_portions => {:include => :exam_portion_scores}})}
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

  def show
    super do |format|
      format.json { render :json => @exam.as_json(:include => {:exam_portions => {:include => :exam_portion_scores}})}
    end
  end

  def destroy
    #destroy! :flash => !request.xhr?
    @exam.destroy
    respond_to do |format|
        format.js { render :nothing => true }
    end
  end

  def FixDigit num, digitNum
    fixNum = 10 ** digitNum
    num = (num * fixNum).truncate()
    return num.to_f / fixNum
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

    @student_total_scores = Hash.new { |hash,key| hash[key] = {} }
    @student_total_weights = Hash.new { |hash,key| hash[key] = {} }
    @exam_averages = Hash.new {0.0}
    @exam_weight_averages = Hash.new {0.0}
    @weighting_score = true

    @students.each do |student|
      @exams.each do |exam|
        @student_total_scores[student.id][exam.id] = 0.0
        @student_total_weights[student.id][exam.id] = 0.0
        exam.exam_portions.each do |portion|
          if student.exam_portion_scores.where(:exam_portion_id => portion.id).first.nil?
            score = ExamPortionScore.new
            score.student_id = student.id
            score.exam_portion_id = portion.id
            score.save
          else
            @student_total_scores[student.id][exam.id] += student.exam_portion_scores.where(:exam_portion_id => portion.id).first.score.to_f
            if exam.use_weighting
              @student_total_weights[student.id][exam.id] +=  (portion.weight.to_f / 100) * student.exam_portion_scores.where(:exam_portion_id => portion.id).first.score.to_f
            end
          end
        end
        @exam_averages[exam.id] += @student_total_scores[student.id][exam.id]
        if exam.use_weighting
          @exam_weight_averages[exam.id] += @student_total_weights[student.id][exam.id]
        end
      end
    end

    # Exam Averaes Calculation -----↓
    @exams.each do |exam|
      @exam_averages[exam.id] = FixDigit @exam_averages[exam.id] / @students.length, 4
      if exam.use_weighting
        @exam_wight_averages[exam.id] = FixDigit @exam_weight_averages[exam.id] / @students.length, 4
      end
    end

    # Deviation Calculation -----↓
    @deviation = Hash.new { |hash,key| hash[key] = {} }
    stdDev = 0.0
    devMem = 0.0
    @exams.each do |exam|
      @students.each do |student|
        if exam.use_weighting
          stdDev += (@student_total_weights[student.id][exam.id] - @exam_weight_averages[exam.id]) ** 2
        else
          stdDev += (@student_total_scores[student.id][exam.id] - @exam_averages[exam.id]) ** 2
        end
      end
      stdDev = Math.sqrt stdDev / @students.length
      @students.each do |student|
        @deviation[student.id][exam.id] = 0.0
        if exam.use_weighting
          devMem = (@student_total_weights[student.id][exam.id] - @exam_weight_averages[exam.id]) / stdDev
        else
          devMem = (@student_total_scores[student.id][exam.id] - @exam_averages[exam.id]) / stdDev
        end

        if devMem.nan?
          @deviation[student.id][exam.id] = 50
        else
          @deviation[student.id][exam.id] = FixDigit devMem * 10 + 50, 4
        end
      end
    end

    # WIP Grade and Rank Calculation -----↓
    @exams.each do |exam|
      scores = []
      if exam.use_weighting
        @students.each do |student|
          scores.push @student_total_weights[student.id][exam.id]
        end
      else
        @students.each do |student|
          scores.push @student_total_scores[student.id][exam.id]
        end
      end
      scores.sort!().reverse!()

    end

    respond_to do |format|
      format.json { render :json => {:student_total_scores => @student_total_scores,
                                     :exams => @exams.as_json(:include => {:exam_portions => {:include => :exam_portion_scores }}),
                                     :course => @course,
                                     :exam_averages => @exam_averages,
                                     :deviation => @deviation,
                                     :students => Student.decrypt_student_fields(@students)
                                     }}

      format.html { render "exams/grading" }
    end
  end

  def calculations
    respond_to do |format|
      format.json {render :json => {:hello => :world}}
    end
  end

  def update_score
    @exam_portion_score = ExamPortionScore.find_or_create_by_student_id_and_exam_portion_id(params[:exam_portion_score][:student_id], params[:exam_portion_score][:exam_portion_id])
    @exam_portion_score.score = params[:exam_portion_score][:score]
    if @exam_portion_score.save
      @student_id = Student.find(params[:exam_portion_score][:student_id]).id
      exam = Exam.find(params[:id])
      exam_portions = exam.exam_portions
      @exam_id = exam.id.to_s
      exam_portions_ids = exam_portions.pluck(:id)
      student_exam_portion_scores = ExamPortionScore.where(:student_id => params[:exam_portion_score][:student_id] , :exam_portion_id => exam_portions_ids )
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
          format.js { render :json => @exam_portion_score}
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
