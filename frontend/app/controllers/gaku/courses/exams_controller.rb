module Gaku
  class Courses::ExamsController < GakuController

    respond_to :html
    respond_to :js, only: :index

    def index
      @course = Course.find(params[:course_id])
      respond_with @course
    end

    def grading
      @course = Course.find(params[:course_id])
      @exam = Exam.find(params[:id])
      @students = @course.students
      @grading_methods = @course.grading_methods

      @grading_calculations = Grading::Collection::Calculations.new(@grading_methods, @students, @exam).calculate

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
