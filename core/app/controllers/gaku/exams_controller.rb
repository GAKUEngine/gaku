module Gaku
  class ExamsController < GakuController
    inherit_resources
    actions :index, :show, :new, :create, :update, :edit, :destroy
    
    include Gaku::Core::Grading::Calculations

    before_filter :exam, :only => [:show, :create_exam_portion]
    before_filter :load_before_show, :only => :show
    before_filter :load_before_new, :only => :new
    before_filter :exams_count, :only => [:create, :destroy]

    def export_xls
      @course = Course.find(params[:course_id])
      @students = @course.students

      book = Spreadsheet::Workbook.new
      summary_sheet = book.create_worksheet
      summary_sheet.name = 'Exam Summary Sheet'
      @exams = @course.syllabus.exams
      @exams.each do |exam|

        #dynamicly merging cells
        exam_portion_count = exam.exam_portions.count

        #create worksheet for current exam
        exam_sheet = book.create_worksheet :name => exam.name

        # formating and merging cells
        format = Spreadsheet::Format.new :weight => :bold, :align => :center
        exam_sheet.row(0).default_format = format
        exam_sheet.row(1).default_format = format
        exam_sheet.row(2).default_format = format

        exam_sheet.merge_cells(1,0,1,3)
        exam_sheet.merge_cells(1,4,1,3 + exam_portion_count)


        #first info row
        exam_sheet.row(0)[0] = 'Course Code:'
        exam_sheet.row(0)[1] = @course.code
        exam_sheet.row(0)[2] = 'Course ID:'
        exam_sheet.row(0)[3] = @course.id
        exam_sheet.row(0)[4] = 'Exam Name:'
        exam_sheet.row(0)[5] = exam.name
        exam_sheet.row(0)[6] = 'Exam ID:'
        exam_sheet.row(0)[7] = exam.id

        # table header cells
        exam_sheet.row(1).concat ['Student','','','', "#{exam.name}"]
        exam_sheet.row(2).concat ['id','Class', 'Seat Number','Name']
        exam.exam_portions.each_with_index do |portion, index|
          exam_sheet.row(2)[4 + index] = portion.name
        end

        #students info section
        @students.each_with_index do |student, index|
          exam_sheet.row(3 + index)[0] = student.id
          # exam_sheet.row(2 + index)[0] = ?  - class
          # exam_sheet.row(2 + index)[1] = ?  - seat number
          exam_sheet.row(3 + index)[3] = student.full_name

          # studens/exam_portion score matrix
          exam.exam_portions.each_with_index do |portion, portion_index|

            #this method should be improved. many queries to db
            portion_score = student.exam_portion_scores.where(:exam_portion_id => portion.id).first

            exam_sheet.row(3 + index)[(4 + portion_index.to_i)] = portion_score.score rescue ''
          end
        end
      end

      spreadsheet = StringIO.new
      book.write spreadsheet
      send_data spreadsheet.string, :filename => "#{@course.code}.xls", :type =>  "application/vnd.ms-excel"
    end

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
          format.js {render 'gaku/exams/exam_portions/create_exam_portion'}
        end
      end
    end

    def new
      super do |format|
        format.js { render 'new'}
      end
    end

    def create
      super do |format|
        format.js { render 'create' }
      end
    end

    def show
      super do |format|
        format.json { render :json => @exam.as_json(:include => {:exam_portions => {:include => :exam_portion_scores}})}
      end
    end

    def edit
      super do |format|
        format.js { render 'edit'}
      end
    end

    def update
      super do |format|
        @exams = Exam.all
        @notable = exam
        @notable_resource = @notable.class.to_s.underscore.gsub("_","-")
        flash.now[:notice] = 'Exam was successfully updated.'
        format.js { render 'update'}
      end
    end

    def destroy
      super do |format|
        format.js { render 'destroy' }
      end
    end

    def grading
      @course = Course.find(params[:course_id])
      @students = @course.students #.select("id, surname, name")
      find_exams
      
      calculate_totals
      calculate_exam_avarages
      calculate_deviation
      calculate_rank_and_grade

      respond_to do |format|
        format.json { render :json => {
          :student_total_scores => @student_total_scores.as_json(),
          :exams => @exams.as_json(:include => {:exam_portions => {:include => :exam_portion_scores }},:root => false),
          :course => @course.as_json(:root => false),
          :exam_averages => @exam_averages.as_json(:root => false),
          :deviation => @deviation.as_json(:root => false),
          :students => @students.to_json(:root => false),
          :grades => @grades.as_json(:root => false),
          :ranks => @ranks.as_json(:root => false)
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

    def load_before_new
      @exam = Exam.new
      @master_portion = @exam.exam_portions.new
    end

    # def update_score
      # @exam_portion_score = ExamPortionScore.find_or_create_by_student_id_and_exam_portion_id(params[:exam_portion_score][:student_id], params[:exam_portion_score][:exam_portion_id])
      # @exam_portion_score.score = params[:exam_portion_score][:score]
      # if @exam_portion_score.save
        # @student_id = Student.find(params[:exam_portion_score][:student_id]).id
        # exam = Exam.find(params[:id])
        # exam_portions = exam.exam_portions
        # @exam_id = exam.id.to_s
        # exam_portions_ids = exam_portions.pluck(:id)
        # student_exam_portion_scores = ExamPortionScore.where(:student_id => params[:exam_portion_score][:student_id] , :exam_portion_id => exam_portions_ids )
        # student_scores = student_exam_portion_scores.pluck(:score)
        # @student_total_score = student_scores.inject{|sum,x| sum + x.to_f }
  #
        # @student_weights_total = 0.0
        # if exam.use_weighting
          # student_exam_portion_scores.each do |eps|
            # @student_weights_total += eps.score.to_f * (eps.exam_portion.weight.to_f / 100)
          # end
        # end
  #
        # respond_to do |format|
            # format.js { render 'update_score' }
            # format.js { render :json => @exam_portion_score}
          # end
        # end
      # end
    # end

    private
      def exam
        @exam = Exam.find(params[:id])
      end

      def load_before_show
        @exam.exam_portions.build
        @notable = @exam
        @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
      end

      def exams_count 
        @exams_count = Exam.count
      end

      def find_exams
        if params[:id] != nil
          @exams = Exam.find_all_by_id(params[:id])
        else
          @exams = @course.syllabus.exams.all
          # TODO calculate all grades and put them in here
          # @grades = 1
        end
      end
  end
end
