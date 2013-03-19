module Gaku
  module Admin
    class ExamsController < GakuController
      include Gaku::Core::Grading::Calculations

      inherit_resources
      respond_to :js, :html


      def grading

      # @course = Course.find(params[:course_id])
      phase = AdmissionPhase.find(params[:admission_phase_id])
      records = phase.admission_phase_records
      @students = []
      records.each {|record|
        @students << record.admission.student
      }
      #@students = Student.first(3) #students ....
      @exams = Exam.where(:id => params[:id]) #don`t use find .. because need relation

      calculate_totals
      calculate_exam_averages
      calculate_deviation
      calculate_rank_and_grade

      @path_to_exam = admin_admission_phase_path(:id => params[:admission_phase_id])

      #exam_portions need reload to properly include exam_portion_score in as_json
      @exams.each { |exam| exam.exam_portions.reload }

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
          :path_to_exam => @path_to_exam.to_json,
          :completion => @completion
        }}
        format.html { render "gaku/exams/grading" }
      end
      end

    end
  end
end