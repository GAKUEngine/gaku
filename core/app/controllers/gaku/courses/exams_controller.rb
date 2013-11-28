module Gaku
  class Courses::ExamsController < GakuController

    respond_to :html

    def grading
      @course = Course.find(params[:course_id])
      @exam = Exam.find(params[:id])
      @students = @course.students

      calculate_totals


      respond_with @exam
    end

    private

    def init_portion_scores
      @students.each do |student|
        @exam.exam_portions.each do |portion|
          unless portion.exam_portion_scores.pluck(:student_id).include?(student.id)
            ExamPortionScore.create!(exam_portion: portion, student: student)
          end
        end
      end
    end

  end
end
